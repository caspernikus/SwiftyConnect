//
//  SwiftySteemTests.swift
//  SwiftySteemTests
//
//  Created by Benedikt Veith on 19.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import XCTest

class SwiftySteemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        Steem.sharedInstance.initialize(config: ["api": "https://api.steemit.com"])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_get_accounts() {
        let expectations = expectation(description: "Wait for get_accounts to load.")

        Steem.sharedInstance.api.getAccounts(accounts: ["moonrise"]) { (error) in
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_account_history() {
        let expectations = expectation(description: "Wait for get_account_history to load.")
        
        Steem.sharedInstance.api.getAccountHistory(name: "moonrise", from: -1, limit: 5) { (error) in
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_trending_tags() {
        let expectations = expectation(description: "Wait for get_trending_tags to load.")
        
        Steem.sharedInstance.api.getTrendingTags(afterTag: "", limit: 10) { (error, response) in
//            let res = response as? NSDictionary
//            print(res!["result"])
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_discussions_by_trending() {
        let expectations = expectation(description: "Wait for get_discussions_by_trending to load.")
        
        let query = QueryDiscussionsBy(tag: "utopian-io", start_author: nil, start_permlink: nil, limit: 1)
        
        Steem.sharedInstance.api.getDiscussionsByTrending(query: query) { (error) in
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_dynamic_global_properties() {
        let expectations = expectation(description: "Wait for get_dynamic_global_properties to load.")
        
        Steem.sharedInstance.api.getDynamicGlobalProperties() { (error, response) in
            print(response)
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_block() {
        let expectations = expectation(description: "Wait for get_block to load.")
        
        Steem.sharedInstance.api.getBlock(blockNumber: 20265553) { (error, response) in
            print(response)
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
}
