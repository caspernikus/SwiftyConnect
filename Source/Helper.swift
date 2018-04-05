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
            if error != nil {
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
    
    public func reputation(rawReputation: Double) -> Double {
        let log_10 = log10(rawReputation)
        let reputation = ((log_10 - 9) * 9) + 25
        
        return floor(reputation)
    }
}
