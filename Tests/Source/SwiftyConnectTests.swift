//
//  SwiftySteemTests.swift
//  SwiftySteemTests
//
//  Created by Benedikt Veith on 19.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import XCTest
import SwiftyConnect

class SwiftyConnectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Use fallback API URI
        Steem.sharedInstance.initialize(config: [:])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_helpers() {
        let expectations = expectation(description: "Wait for calculate_steempower to load.")
        
        Steem.sharedInstance.helper.calculateSteempower(vestingShares: "675898.790497 VESTS") { (error, steempower) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        let vp = Steem.sharedInstance.helper.getVotingPower(votingPower: 10000, lastVoteTime: "2018-04-05T06:55:03")
        
        XCTAssert(vp == 100.0)
        
        let rep = Steem.sharedInstance.helper.reputation(rawReputation: 7677323209728)
        
        XCTAssert(rep == 59.0)
    }
    
    func test_accounts() {
        var expectations = expectation(description: "Wait for get_accounts to load.")

        Steem.sharedInstance.api.getAccounts(accounts: ["moonrise"]) { (error, response) in
            if error != nil {
                return;
            }

            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_account_history to load.")
        
        Steem.sharedInstance.api.getAccountHistory(name: "moonrise", from: 10, limit: 1) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_account_count to load.")
        
        Steem.sharedInstance.api.getAccountCount { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
//        expectations = expectation(description: "Wait for get_account_references to load.")
//
//        Steem.sharedInstance.api.getAccountReferences(id: 1) { (error, response) in
//            if error != nil {
//                return;
//            }
//
//            expectations.fulfill()
//        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for lookup_account_names to load.")
        
        Steem.sharedInstance.api.lookupAccountNames(accounts: ["moonrise"]) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for lookup_accounts to load.")
        
        Steem.sharedInstance.api.lookupAccounts(lowerBoundName: "moon", limit: 1) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_conversion_requests to load.")
        
        Steem.sharedInstance.api.getConversionRequests(account: "moonrise") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_owner_history to load.")
        
        Steem.sharedInstance.api.getOwnerHistory(account: "moonrise") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_recovery_request to load.")
        
        Steem.sharedInstance.api.getRecoveryRequest(account: "moonrise") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_follow() {
        var expectations = expectation(description: "Wait for get_followers to load.")
        
        Steem.sharedInstance.api.getFollowers(name: "moonrise", start: "", type: "blog", limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_following to load.")
        
        Steem.sharedInstance.api.getFollowing(name: "moonrise", start: "", type: "blog", limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_follow_count to load.")
        
        Steem.sharedInstance.api.getFollowCount(account: "moonrise") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_account_history() {
        let expectations = expectation(description: "Wait for get_account_history to load.")
        
        Steem.sharedInstance.api.getAccountHistory(name: "moonrise", from: -1, limit: 5) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_trending_tags() {
        let expectations = expectation(description: "Wait for get_trending_tags to load.")
        
        Steem.sharedInstance.api.getTrendingTags(afterTag: "", limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_discussions_by_queries() {
        var expectations = expectation(description: "Wait for get_discussions_by_trending to load.")
        
        var query = QueryDiscussionsBy(tag: "utopian-io", start_author: nil, start_permlink: nil, limit: 1)
        
        Steem.sharedInstance.api.getDiscussionsByTrending(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_hot to load.")
        
        Steem.sharedInstance.api.getDiscussionsByHot(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_blog to load.")
        
        Steem.sharedInstance.api.getDiscussionsByBlog(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_feed to load.")
        
        Steem.sharedInstance.api.getDiscussionsByFeed(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_votes to load.")
        
        Steem.sharedInstance.api.getDiscussionsByVotes(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_active to load.")
        
        Steem.sharedInstance.api.getDiscussionsByActive(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_payout to load.")
        
        Steem.sharedInstance.api.getDiscussionsByPayout(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_cashout to load.")
        
        Steem.sharedInstance.api.getDiscussionsByCashout(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_created to load.")
        
        Steem.sharedInstance.api.getDiscussionsByCreated(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_children to load.")
        
        Steem.sharedInstance.api.getDiscussionsByChildren(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_discussions_by_comments to load.")
        
        query = QueryDiscussionsBy(tag: "utopian-io", start_author: "moonrise", start_permlink: nil, limit: 1)
        
        Steem.sharedInstance.api.getDiscussionsByComments(query: query) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_dynamic_global_properties() {
        let expectations = expectation(description: "Wait for get_dynamic_global_properties to load.")
        
        Steem.sharedInstance.api.getDynamicGlobalProperties() { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_get_block_and_states() {
        var expectations = expectation(description: "Wait for get_block to load.")
        
        Steem.sharedInstance.api.getBlock(blockNumber: 20265553) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_state to load.")
        
        Steem.sharedInstance.api.getState(blockNumber: 20265553) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_block_header to load.")
        
        Steem.sharedInstance.api.getBlockHeader(blockNumber: 20265553) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_globals() {
        var expectations = expectation(description: "Wait for get_config to load.")
        
        Steem.sharedInstance.api.getConfig { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_dynamic_global_properties to load.")
        
        Steem.sharedInstance.api.getDynamicGlobalProperties { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_chain_properties to load.")
        
        Steem.sharedInstance.api.getChainProperties { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_feed_history to load.")
        
        Steem.sharedInstance.api.getFeedHistory { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_current_median_history_price to load.")
        
        Steem.sharedInstance.api.getCurrentMedianHistoryPrice { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_hardfork_version to load.")
        
        Steem.sharedInstance.api.getHardforkVersion { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_next_sched_hardfork to load.")
        
        Steem.sharedInstance.api.getNextScheduledHardfork { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_vesting_delegations to load.")
        
        Steem.sharedInstance.api.getVestingDelegations(account: "moonrise", from: 0, limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_authority() {
        var expectations = expectation(description: "Wait for get_content to load.")
        
        Steem.sharedInstance.api.getContent(author: "moonrise", permlink: "swiftyconnect-steemconnect-for-ios") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_active_votes to load.")
        
        Steem.sharedInstance.api.getActiveVotes(author: "moonrise", permlink: "swiftyconnect-steemconnect-for-ios") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_account_votes to load.")
        
        Steem.sharedInstance.api.getAccountVotes(account: "moonrise") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_content to load.")
        
        Steem.sharedInstance.api.getContentReplies(author: "moonrise", permlink: "swiftyconnect-steemconnect-for-ios") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_content to load.")
        
        Steem.sharedInstance.api.getDiscussionsByAuthorBeforeDate(author: "moonrise", startPermlink: "swiftyconnect-steemconnect-for-ios", beforeDate: "2018-03-22T07:40:33", limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_content to load.")
        
        Steem.sharedInstance.api.getRepliesByLastUpdate(author: "moonrise", permlink: "swiftyconnect-steemconnect-for-ios", limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_market() {
        var expectations = expectation(description: "Wait for get_order_book to load.")
        
        Steem.sharedInstance.api.getOrderBook(limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_open_orders to load.")
        
        Steem.sharedInstance.api.getOpenOrders(name: "moonrise") { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_liquidity_queue to load.")
        
        Steem.sharedInstance.api.getLiquidityQueue(name: "moonrise", limit: 1) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
    
    func test_witnesses() {
        var expectations = expectation(description: "Wait for get_witness_count to load.")
        
        Steem.sharedInstance.api.getWitnessCount { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_active_witnesses to load.")
        
        Steem.sharedInstance.api.getActiveWitnesses { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_witnesses_by_vote to load.")
        
        Steem.sharedInstance.api.getWitnessesByVote(from: 0, limit: 10) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
        
        expectations = expectation(description: "Wait for get_witnesses to load.")
        
        Steem.sharedInstance.api.getWitnesses(witnessIds: ["2781"]) { (error, response) in
            if error != nil {
                return;
            }
            
            expectations.fulfill()
        }
        
        wait(for: [expectations], timeout: 10)
    }
}
