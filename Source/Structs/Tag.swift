//
//  Tag.swift
//  SwiftySteem
//
//  Created by Benedikt Veith on 22.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation

struct GetTrendingTags: Codable {
    let jsonrpc: String
    let id: Int
    let method: String
    let params: [String]
}

struct GetDiscussionsBy: Codable {
    let jsonrpc: String
    let id: Int
    let method: String
    let params: [QueryDiscussionsBy]
}

public struct QueryDiscussionsBy: Codable {
    let tag: String?
    let start_author: String?
    let start_permlink: String?
    let limit: Int?
    
    public init(tag: String?, start_author: String?, start_permlink: String?, limit: Int?) {
        self.tag = tag
        self.start_author = start_author
        self.start_permlink = start_permlink
        self.limit = limit
    }
}

// FUTURE USAGE EXAMPLE

struct ResponseGetTrendingTags: Decodable {
    let id: Int
    let result: [TrendingTag]
}

struct TrendingTag: Decodable {
    let name: String
    let total_payouts: String
    let net_votes: Int
    let top_posts: Int
    let comments: Int
    let trending: String
}
