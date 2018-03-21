//
//  Broadcast.swift
//  SwiftySteem
//
//  Created by Benedikt Veith on 27.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation

public struct JSONMetadata: Codable {
    let tags: [String]
    let links: [String?]
    let image: [String?]
    let format: String
    let app: String
    
    public init(tags: [String], links: [String?], image: [String?], format: String, app: String) {
        self.tags = tags
        self.links = links
        self.image = image
        self.format = format
        self.app = app
    }
}

enum StringifyError: Error {
    case isNotValidJSONObject
}

struct JSONStringify {
    
    let value: Any
    
    func stringify(prettyPrinted: Bool = false) throws -> String {
        let options: JSONSerialization.WritingOptions = prettyPrinted ? .prettyPrinted : .init(rawValue: 0)
        if JSONSerialization.isValidJSONObject(self.value) {
            let data = try JSONSerialization.data(withJSONObject: self.value, options: options)
            if let string = String(data: data, encoding: .utf8) {
                return string
                
            }
        }
        throw StringifyError.isNotValidJSONObject
    }
}
protocol Stringifiable {
    func stringify(prettyPrinted: Bool) throws -> String
}

extension Stringifiable {
    func stringify(prettyPrinted: Bool = false) throws -> String {
        return try JSONStringify(value: self).stringify(prettyPrinted: prettyPrinted)
    }
}

extension Dictionary: Stringifiable {}

public class Broadcast {
    
    public init() {}
    
    public func vote(voter: String, author: String, permlink: String, weight: Int, completion:((JSONString) -> Void)?) {
        Steem.sharedInstance.auth.call(url: "/broadcast", data: [
            "operations": [
                ["vote", [
                    "voter": voter,
                    "author": author,
                    "permlink": permlink,
                    "weight": weight
                    ]
                ]
            ]
        ], callback: completion!)
    }
    
    public func reblog(account: String, author: String, permlink: String, completion:((JSONString) -> Void)?) {
        do {
            let json = try JSONStringify(value: [
                "reblog",
                [
                    "account": account,
                    "author": author,
                    "permlink": permlink
                ]
            ]).stringify()
            
            Steem.sharedInstance.auth.call(url: "/broadcast", data: [
                "operations": [
                    ["custom_json", [
                        "required_auths": [],
                        "required_posting_auths": [account],
                        "id": "follow",
                        "json": json
                        ]
                    ]
                ]
            ], callback: completion!)
        } catch let error {
            print(error)
            completion!(["error": error])
        }
    }
    
    public func customJSON(account: String, json: JSONString, completion:((JSONString) -> Void)?) {
        do {
            let json = try JSONStringify(value: json).stringify()
            
            Steem.sharedInstance.auth.call(url: "/broadcast", data: [
                "operations": [
                    ["custom_json", [
                        "required_auths": [],
                        "required_posting_auths": [account],
                        "id": "follow",
                        "json": json
                        ]
                    ]]
            ], callback: completion!)
        } catch let error {
            print(error)
            completion!(["error": error])
        }
    }
    
    // PRAGMA MARK: FOLLOW API
    
    public func follow(follower: String, following: String, completion:((JSONString) -> Void)?) {
        do {
            let json = try JSONStringify(value: [
                "follow",
                [
                    "follower": follower,
                    "following": following,
                    "what": ["blog"]
                ]
            ]).stringify()
            
            Steem.sharedInstance.auth.call(url: "/broadcast", data: [
                "operations": [
                    ["custom_json", [
                        "required_auths": [],
                        "required_posting_auths": [follower],
                        "id": "follow",
                        "json": json]
                    ]
                ]
            ], callback: completion!)
        } catch let error {
            print(error)
            completion!(["error": error])
        }
    }
    
    public func unfollow(unfollower: String, unfollowing: String, completion:((JSONString) -> Void)?) {
        do {
            let json = try JSONStringify(value: [
                "follow",
                [
                    "follower": unfollower,
                    "following": unfollowing,
                    "what": []
                ]
            ]).stringify()
            
            Steem.sharedInstance.auth.call(url: "/broadcast", data: [
                "operations": [
                    ["custom_json", [
                        "required_auths": [],
                        "required_posting_auths": [unfollower],
                        "id": "follow",
                        "json": json]
                    ]
                ]
            ], callback: completion!)
        } catch let error {
            print(error)
            completion!(["error": error])
        }
    }
    
    public func ignore(follower: String, following: String, completion:((JSONString) -> Void)?) {
        do {
            let json = try JSONStringify(value: [
                "follow",
                [
                    "follower": follower,
                    "following": following,
                    "what": ["ignore"]
                ]
            ]).stringify()
            
            Steem.sharedInstance.auth.call(url: "/broadcast", data: [
                "operations": [
                    ["custom_json", [
                        "required_auths": [],
                        "required_posting_auths": [follower],
                        "id": "follow",
                        "json": json]
                    ]
                ]
            ], callback: completion!)
        } catch let error {
            print(error)
            completion!(["error": error])
        }
    }
    
    // PRAGMA MARK: CLAIM
    
    public func claimRewardBalance(account: String, rewardSBD: String, rewardSteem: String, rewardVests: Int, completion:((JSONString) -> Void)?) {
        Steem.sharedInstance.auth.call(url: "/broadcast", data: [
            "operations": [
                ["claim_reward_balance", [
                    "account": account,
                    "reward_sbd": rewardSBD,
                    "reward_steem": rewardSteem,
                    "reward_vests": rewardVests
                    ]
                ]
            ]
        ], callback: completion!)
    }
    
    // PRAGMA MARK: COMMENT
    
    public func comment(parentAuthor: String?, parentPermlink: String?, author: String, permlink: String, title: String, body: String, jsonMetadata: JSONMetadata, completion:((JSONString) -> Void)?) {
        Steem.sharedInstance.auth.call(url: "/broadcast", data: [
            "operations": [
                ["comment", [
                    "parent_author": parentAuthor ?? "",
                    "parent_permlink": parentPermlink ?? "",
                    "author": author,
                    "permlink": permlink,
                    "title": title,
                    "body": body,
                    "json_metadata": jsonMetadata
                    ]
                ]
            ]
        ], callback: completion!)
    }
}
