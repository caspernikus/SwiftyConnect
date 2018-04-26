//
//  Helper.swift
//  SwiftyConnect
//
//  Created by Benedikt Veith on 27.03.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation

extension String {
    mutating func removingRegexMatches(pattern: String, replaceWith: String = "") {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            self = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return
        }
    }
}

public class Helper {
    
    public init() {}
    
    public func calculateSteempower(vestingShares: String, callback:((Any?, Float?) -> Void)?) {
        Steem.sharedInstance.api.getDynamicGlobalProperties { (error, response) in
            guard error == nil else {
                callback!(error, nil)
                return;
            }
            
            let resp = response as! NSDictionary
            let result = resp["result"] as! NSDictionary
            
            let totalVestingFundSteem = result["total_vesting_fund_steem"] as! String
            let totalVestingShares = result["total_vesting_shares"] as! String
            
            let steempower = Float(totalVestingFundSteem.split(separator: " ")[0])! * (Float(vestingShares.split(separator: " ")[0])! / Float(totalVestingShares.split(separator: " ")[0])!)
            
            callback!(nil, steempower)
        }
    }
    
    public func getVotingPower(votingPower: Int, lastVoteTime: String) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let last_vote_time = dateFormatter.date(from: lastVoteTime)
        let today = Date()
        
        let secondsAgo = today.timeIntervalSince(last_vote_time!)
        
        let vpow = Double(votingPower) + (10000 * secondsAgo / 432000)
        
        return min(vpow / 100, 100)
    }
    
    public func createCommentPermlink(parentAuthor: String, parentPermlink: String) -> String {
        var permlink = parentPermlink
        let nowTimestamp = Date().timeIntervalSince1970
        
        permlink.removingRegexMatches(pattern: "/(-\\d+.\\d+)/g", replaceWith: "")
        
        return "re-\(parentAuthor)-\(permlink)-\(nowTimestamp)"
    }
    
    public func getSteemAndSbdPrices(currency: String, callback:((Any?, NSDictionary?) -> Void)?) {
        Steem.sharedInstance.api.client.getData(url: "https://api.coinmarketcap.com/v1/ticker/steem/?convert=\(currency)") { (error, response) in
            guard error == nil else {
                callback!(error, nil)
                return
            }
            
            let steem = (response as! NSDictionary)["price_\(currency.lowercased())"] as! String
            
            Steem.sharedInstance.api.client.getData(url: "https://api.coinmarketcap.com/v1/ticker/steem-dollars/?convert=\(currency)") { (error, response) in
                guard error == nil else {
                    callback!(error, nil)
                    return
                }
                
                let sbd = (response as! NSDictionary)["price_\(currency.lowercased())"] as! String
                
                callback!(error, [
                    "steem": steem,
                    "sbd": sbd
                ])
            }
        }
    }
    
    public func convertToCurrency(value: String, currency: String, callback:((Any?, Double?) -> Void)?) {
        let splittedRef = value.split(separator: " ")
        var converted = 0.0
        
        Steem.sharedInstance.helper.getSteemAndSbdPrices(currency: currency) { (error, response) in
            guard error == nil else {
                callback!(error, nil)
                return
            }
            
            let steemPrice = Double(response!["steem"] as! String)
            let sbdPrice = Double(response!["sbd"] as! String)
            
            switch splittedRef[1] {
            case "STEEM":
                converted = Double(splittedRef[0])! * steemPrice!
                break
            case "SBD":
                converted = Double(splittedRef[0])! * sbdPrice!
                break
            default:
                break
            }
            
            callback!(nil, converted)
        }
    }
    
    public func validAccountName(name: String) -> String? {
        if name.count == 0 {
            return "Account name should not be empty"
        } else if name.count < 3 {
            return "Account name should be longer"
        } else if name.count > 16 {
            return "Account namr should be shorter"
        }
        
        let ref = name.split(separator: ".")
        for label in ref {
            
            var regex = try! NSRegularExpression(pattern: "^[a-z]", options: [])
            var matches = regex.matches(in: String(label), options: [], range: NSRange(location: 0, length: label.count))
            
            guard matches.count != 0 else {
                return "Each account segment should start with a letter";
            }
            
            regex = try! NSRegularExpression(pattern: "^[a-z0-9-]*$", options: [])
            matches = regex.matches(in: String(label), options: [], range: NSRange(location: 0, length: label.count))
            
            guard matches.count != 0 else {
                return "Each account segment should have only letters, digits, or dashes";
            }
            regex = try! NSRegularExpression(pattern: "--", options: [])
            matches = regex.matches(in: String(label), options: [], range: NSRange(location: 0, length: label.count))
            
            guard matches.count == 0 else {
              return "Each account segment should have only one dash in a row";
            }
            
            regex = try! NSRegularExpression(pattern: "[a-z0-9]$", options: [])
            matches = regex.matches(in: String(label), options: [], range: NSRange(location: 0, length: label.count))
            
            guard matches.count != 0 else {
              return "Each account segment should end with a letter or digit";
            }

            guard label.count >= 3 else {
              return "Each account segment should be longer";
            }
        }

        
        return nil
    }
    
    public func reputation(rawReputation: Double) -> Double {
        let log_10 = log10(rawReputation)
        let reputation = ((log_10 - 9) * 9) + 25
        
        return floor(reputation)
    }
}
