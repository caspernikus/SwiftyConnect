//
//  Api.swift
//  SwiftySteem
//
//  Created by Benedikt Veith on 20.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}

public class Api {
    
    var client : HttpClient!
    
    public init() {}
    
    let config_default : NSDictionary = [
        "api": "https://api.steemit.com"
    ]
    
    init(config: NSDictionary) {
        var configUsed = config
        let apiUri = configUsed["api"] as? String
        
        if apiUri == nil {
            configUsed = self.config_default
        }
        
        self.client = HttpClient(api: configUsed["api"] as! String)
    }

    // PRAGMA MARK: TAGS
    
    public func getTrendingTags(afterTag: String, limit: Int, completion:((Any?, _ response: Any?) -> Void)?) {
        let getTrendingTags: GetTrendingTags = GetTrendingTags(jsonrpc: "2.0", id: 1, method: "get_trending_tags", params: [afterTag, String(limit)])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getTrendingTags)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
                //      TODO: REPLACE JSON WITH CODABLES !
//                if let responseData = try? JSONDecoder().decode(ResponseGetTrendingTags.self, from: response!) {
//                    completion?(nil, responseData)
//
//                    return
//                }
                
                print("Decoding Error happend - get_trending_tags")
            }
        } catch {
            print("Error parsing JSON Data - get_trending_tags; AfterTag: \(afterTag); Limit: \(limit)");
            return;
        }
    }
    
    public func getDiscussionsByTrending(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_trending", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_trending; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByCreated(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_created", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_created; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByActive(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_active", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_active; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByPayout(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_payout", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_payout; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByCashout(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_cashout", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_cashout; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByVotes(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_votes", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_votes; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByChildren(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_children", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_children; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByHot(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_hot", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_hot; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByFeed(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_feed", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_feed; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByBlog(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_blog", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_blog; Query Object: \(query);");
            return;
        }
    }
    
    public func getDiscussionsByComments(query: QueryDiscussionsBy, completion:((Any?, Any?) -> Void)?) {
        let getDiscussionsByTrending: GetDiscussionsBy = GetDiscussionsBy(jsonrpc: "2.0", id: 1, method: "get_discussions_by_comments", params: [query])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getDiscussionsByTrending)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_comments; Query Object: \(query);");
            return;
        }
    }
    
    // PRAGMA MARK: BLOCKS AND TRANSACTIONS
    
    public func getBlock(blockNumber: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleIntParam = SingleIntParam(jsonrpc: "2.0", id: 1, method: "get_block", params: [blockNumber])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_block; Block Number: \(blockNumber)");
            return;
        }
    }
    
    public func getBlockHeader(blockNumber: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleIntParam = SingleIntParam(jsonrpc: "2.0", id: 1, method: "get_block_header", params: [blockNumber])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_block_header; Block Number: \(blockNumber)");
            return;
        }
    }
    
    public func getState(blockNumber: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleIntParam = SingleIntParam(jsonrpc: "2.0", id: 1, method: "get_state", params: [blockNumber])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_state; Block Number: \(blockNumber)");
            return;
        }
    }
    
    // PRAGMA MARK: GLOBALS
    
    public func getConfig(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_config")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_config;")
            return
        }
    }
    
    public func getDynamicGlobalProperties(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_dynamic_global_properties")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_dynamic_global_properties;")
            return
        }
    }
    
    public func getChainProperties(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_chain_properties")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_chain_properties;")
            return
        }
    }
    
    public func getFeedHistory(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_feed_history")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_feed_history;")
            return
        }
    }
    
    public func getCurrentMedianHistoryPrice(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_current_median_history_price")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_current_median_history_price;")
            return
        }
    }
    
    public func getHardforkVersion(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_hardfork_version")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_hardfork_version;")
            return
        }
    }
    
    public func getNextScheduledHardfork(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_next_scheduled_hardfork")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_next_scheduled_hardfork;")
            return
        }
    }
    
    public func getRewardFund(name: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_reward_fund", params: [name])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_reward_fund;")
            return
        }
    }
    
    public func getVestingDelegations(account: String, from: Int, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_vesting_delegations", params: [account, String(from), String(limit)])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_vesting_delegations;")
            return
        }
    }
    
    // PRAGMA MARK: KEYS
    
    public func getKeyReferences(key: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
                "jsonrpc": "2.0",
                "id": 1,
                "method": "call",
                "params": ["account_by_key_api", "get_key_references", [[key]]]
            ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_key_references; KEY: \(key)")
            return
        }
    }
    
    // PRAGMA MARK: ACCOUNTS
    
    public func getAccounts(accounts: [String], completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: GetAccounts = GetAccounts(jsonrpc: "2.0", id: 1, method: "get_accounts", params: [accounts])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_accounts; Data: \(accounts)");
            return;
        }
    }
    
    public func getAccountReferences(id: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleIntParam = SingleIntParam(jsonrpc: "2.0", id: 1, method: "get_account_references", params: [id])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_account_references; ID: \(id)");
            return;
        }
    }
    
    public func lookupAccountNames(accounts: [String], completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: GetAccounts = GetAccounts(jsonrpc: "2.0", id: 1, method: "lookup_account_names", params: [accounts])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - lookup_account_names; Data: \(accounts)");
            return;
        }
    }
    
    public func lookupAccounts(lowerBoundName: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "call",
            "params": ["database_api", "lookup_accounts", [lowerBoundName, limit]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - lookup_accounts; Lower Bundle Name: \(lowerBoundName); Limit: \(limit)")
            return
        }
    }
    
    public func getAccountCount(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: EmptyParam = EmptyParam(jsonrpc: "2.0", id: 1, method: "get_account_count")
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_account_count;")
            return
        }
    }
    
    public func getConversionRequests(account: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_conversion_requests", params: [account])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_conversion_requests; Account: \(account)");
            return;
        }
    }
    
    public func getAccountHistory(name: String, from: Int, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_account_history", params: [name, String(from), String(limit)])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_accounts; Name: \(name); From: \(from); Limit: \(limit)");
            return;
        }
    }
    
    public func getOwnerHistory(account: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_owner_history", params: [account])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_owner_history; Account: \(account)");
            return;
        }
    }
    
    public func getRecoveryRequest(account: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_recovery_request", params: [account])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_recovery_request; Account: \(account)");
            return;
        }
    }
    
    // PRAGMA MARK: MARKET

    public func getOrderBook(limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleIntParam = SingleIntParam(jsonrpc: "2.0", id: 1, method: "get_order_book", params: [limit])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_order_book; Limit: \(limit)");
            return;
        }
    }
    
    public func getOpenOrders(name: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_open_orders", params: [name])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_open_orders; Name: \(name)");
            return;
        }
    }
    
    public func getLiquidityQueue(name: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleStringParam = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_liquidity_queue", params: [name, String(limit)])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_liquidity_queue; Name: \(name); Limit: \(limit)");
            return;
        }
    }
    
    // PRAGMA MARK: AUTHORITY / VALIDATION
    
    public func getTransaction(trxId: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData: SingleIntParam = SingleIntParam(jsonrpc: "2.0", id: 1, method: "get_transaction", params: [trxId])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_transaction; TrxId: \(trxId)");
            return;
        }
    }
    
    public func getTransactionHex(trx: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_transaction_hex",
            "params": [["trx": trx]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_transaction_hex; Trx: \(trx)");
            return;
        }
    }
    
    public func getRequiredSignatures(trx: Int, availableKeys: [String], completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_required_signatures",
            "params": [["trx": trx], availableKeys]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_required_signatures; Trx: \(trx)");
            return;
        }
    }
    
    public func getPotentialSignatures(trx: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_potential_signatures",
            "params": [["trx": trx]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_potential_signatures; Trx: \(trx)");
            return;
        }
    }
    
    public func verifyAuthority(trx: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "verify_authority",
            "params": [["trx": trx]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - verify_authority; Trx: \(trx)");
            return;
        }
    }
    
    public func verifyAccountAuthority(name: String, key: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "verify_account_authority",
            "params": [name, [key]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - verify_account_authority; Name: \(name); Key: \(key)");
            return;
        }
    }
    
    public func getActiveVotes(author: String, permlink: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_active_votes", params: [author, permlink])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_active_votes; Author: \(author); Permlink: \(permlink)");
            return;
        }
    }
    
    public func getAccountVotes(account: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_account_votes", params: [account])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_account_votes; Account: \(account)");
            return;
        }
    }
    
    public func getContent(author: String, permlink: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_content", params: [author, permlink])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_content; Author: \(author); Permlink: \(permlink)");
            return;
        }
    }
    
    public func getContentReplies(author: String, permlink: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_content_replies", params: [author, permlink])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_content_replies; Author: \(author); Permlink: \(permlink)");
            return;
        }
    }
    
    public func getDiscussionsByAuthorBeforeDate(author: String, startPermlink: String, beforeDate: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_discussions_by_author_before_date", params: [author, startPermlink, beforeDate, String(limit)])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_discussions_by_author_before_date; Author: \(author); startPermlink: \(startPermlink); beforeDate: \(beforeDate); limit: \(limit)");
            return;
        }
    }
    
    public func getRepliesByLastUpdate(author: String, permlink: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData = SingleStringParam(jsonrpc: "2.0", id: 1, method: "get_replies_by_last_update", params: [author, permlink, String(limit)])
        
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(getAccountsData)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_replies_by_last_update; author: \(author); permlink: \(permlink); limit: \(limit)");
            return;
        }
    }
    
    //PRAGMA MARK: WITNESSES
    
    public func getWitnesses(witnessIds: [String], completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_witnesses",
            "params": [witnessIds]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_witnesses; witnessIds: \(witnessIds)");
            return;
        }
    }
    
    public func getWitnessByAccount(name: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_witness_by_account",
            "params": [name]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_witness_by_account; Name: \(name)");
            return;
        }
    }
    
    public func getWitnessesByVote(from: Int, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_witnesses_by_vote",
            "params": [String(from), String(limit)]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_witnesses_by_vote; From: \(from); Limit: \(limit)");
            return;
        }
    }
    
    public func lookupWitnessAccounts(lowerBoundName: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "lookup_witness_accounts",
            "params": [lowerBoundName, String(limit)]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - lookup_witness_accounts; lowerBoundName: \(lowerBoundName); limit: \(limit)");
            return;
        }
    }
    
    public func getWitnessCount(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_witness_count"
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_witness_count;");
            return;
        }
    }
    
    public func getActiveWitnesses(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_active_witnesses"
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_active_witnesses;");
            return;
        }
    }
    
    public func getMinerQueue(completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "get_miner_queue"
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_miner_queue;");
            return;
        }
    }
    
    //PRAGMA MARK: FOLLOW
    
    public func getFollowers(name: String, start: String, type: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "call",
            "params": ["follow_api", "get_followers", [name, start, type, String(limit)]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_followers;");
            return;
        }
    }
    
    public func getFollowCount(account: String, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "call",
            "params": ["follow_api", "get_follow_count", [account]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_followers;");
            return;
        }
    }
    
    public func getFollowing(name: String, start: String, type: String, limit: Int, completion:((Any?, Any?) -> Void)?) {
        let getAccountsData : [String : Any] = [
            "jsonrpc": "2.0",
            "id": 1,
            "method": "call",
            "params": ["follow_api", "get_following", [name, start, type, String(limit)]]
        ];
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: getAccountsData, options: .prettyPrinted)
            
            self.client.useEndpoint(jsonData: jsonData) { (error, response) in
                if (error != nil) {
                    completion!(error, nil)
                    return
                }
                
                completion!(nil, response)
            }
        } catch {
            print("Error parsing JSON Data - get_following;");
            return;
        }
    }
}
