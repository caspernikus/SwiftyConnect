//
//  Auth.swift
//  SwiftySteem
//
//  Created by Benedikt Veith on 28.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation
import UIKit
import OAuth2

public typealias JSONString = [String : Any]

public class Auth {
    
    public init() {}
    
    var oauth2 : OAuth2CodeGrantNoTokenType?
    var config : NSDictionary = [:]
    var loader : OAuth2DataLoader!
    
    public func setConfig(conf: NSDictionary) {
        config = conf
        
        oauth2 = OAuth2CodeGrantNoTokenType(settings: [
            "client_id": conf["client_id"] as! String,
            "client_secret": conf["client_secret"] as! String,
            "authorize_uri": conf["authorize_uri"] as! String,
            "token_uri": conf["token_uri"] as! String,
            "redirect_uris": conf["redirect_uris"] as! [String],
            "scope": conf["scope"] as! String,
            "keychain": true,
            "secret_in_body": true,
            "verbose": conf["should_Debug"] as! Bool,
        ] as OAuth2JSON)
        
        if (conf["should_Debug"] as! Bool) {
            oauth2?.logger = OAuth2DebugLogger(.debug)
        }
        
        loader = OAuth2DataLoader(oauth2: oauth2!)
    }
    
    public func getConfig() -> NSDictionary {
        return self.config
    }
    
    public func isAuthorized() -> Bool {
        if oauth2!.accessToken == nil && oauth2!.refreshToken == nil {
            return false
        }
        
        if oauth2!.accessToken != nil && oauth2!.refreshToken != nil && oauth2!.accessToken!.count == 0 && oauth2!.refreshToken!.count == 0 {
            return false
        }
        
        if oauth2!.accessToken != nil && oauth2!.refreshToken == nil && oauth2!.accessToken!.count == 0 {
            return false
        }
        
        if oauth2!.accessToken == nil && oauth2!.refreshToken != nil && oauth2!.refreshToken!.count == 0 {
            return false
        }
        
        return true
    }
    
    func getBasePath() -> String {
        return "https://v2.steemconnect.com/api"
    }
    
    func call(url: String, data: NSDictionary, callback: @escaping ((JSONString) -> Swift.Void)) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            
            var req = URLRequest(url: URL(string: "\(self.getBasePath())\(url)")!)
            req.httpMethod = "POST"
            req.httpBody = jsonData
            
            var headers = req.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            req.allHTTPHeaderFields = headers

            loader.perform(request: req) { (response) in
                if (response.response.statusCode != 200) {
                    callback([
                        "error": response.response.statusString,
                        "error-code": response.response.statusCode
                    ])
                    return
                }
                
                do {
                    let json = try response.responseJSON()
                    
                    callback(json)
                }
                catch let error {
                    print(error)
                    
                    callback([
                        "error": error
                    ])
                }
            }
        } catch let error {
            print("Error parsing JSON Data: \(data)");
            callback([
                "error": error
            ])
        }
    }
    
    public func revoke(callback: @escaping ((Bool) -> Swift.Void)) {
        var req = oauth2!.request(forURL: URL(string: "\(getBasePath())/oauth2/token/revoke")!)
        req.httpMethod = "POST"

        oauth2!.perform(request: req) { (response) in
            do {
                _ = try response.responseJSON()
                
                self.oauth2!.forgetTokens()
                
                callback(true)
            } catch let error {
                print(error)
                callback(false)
            }
        }
    }
    
//    func revokeApp(callback: @escaping ((Bool) -> Swift.Void)) {
//        let req = oauth2!.request(forURL: URL(string: "https://steemconnect.com/api/token/revoke/user/\(oauth2!.clientId!)")!)
//
//        oauth2!.perform(request: req) { (response) in
//            do {
//                _ = try response.responseJSON()
//
//                callback(true)
//            } catch let error {
//                print(error)
//                callback(false)
//            }
//        }
//    }
    
    public func handleRedirectURL(url: URL) {
        oauth2!.handleRedirectURL(url)
    }
    
    public func me(callback: @escaping ((JSONString) -> Swift.Void)) {
        loader.perform(request: URLRequest(url: URL(string: "\(getBasePath())/me")!)) { (response) in
            do {
                let json = try response.responseJSON()
                callback(json)
            }
            catch let error {
                print(error)
            }
        }
    }
    
    public func updateUserMetadata(userMetadata: JSONString, callback: @escaping ((JSONString) -> Swift.Void)) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userMetadata, options: .prettyPrinted)
            
            var req = URLRequest(url: URL(string: self.getBasePath() + "/me")!)
            req.httpMethod = "PUT"
            req.httpBody = jsonData
            
            var headers = req.allHTTPHeaderFields ?? [:]
            headers["Content-Type"] = "application/json"
            req.allHTTPHeaderFields = headers
            
            loader.perform(request: req) { (response) in
                do {
                    let json = try response.responseJSON()
                    
                    callback(json)
                }
                catch let error {
                    print(error)
                    
                    callback([
                        "error": error
                    ])
                }
            }
        } catch let error {
            print("Error parsing JSON Data: \(userMetadata)");
            callback([
                "error": error
            ])
        }
    }
    
    public func authorize(callback: @escaping ((JSONString) -> Swift.Void)) {
        loader.perform(request: URLRequest(url: URL(string: "\(getBasePath())/me")!)) { (response) in
            do {
                let json = try response.responseJSON()
                callback(json)
            }
            catch let error {
                print(error)
            }
        }
    }
}
