# SwiftyConnect
SteemConnect Library for iOS / Swift

![swifty.png](https://raw.githubusercontent.com/caspernikus/SwiftyConnect/master/wallpaper.png)

## Current Version: 0.1.4

### How To Use

#### Installation
**Carthage**
```
github "caspernikus/SwiftyConnect" ~> 0.1.4
```
(When building SwiftyConnect the lib OAuth2 is also builded, there is no need to add OAuth2 inside your project, since SwiftyConenct contains OAuth2!)

#### Usage
SwiftyConnects make use of one main class called Steem. To use Steem you should ALWAYS use the sharedInstance => `let steem = Steem.sharedInstance`

You are strongly advised to setup Steem inside your AppDelegate (Please add an API Endpoint if you want to use the API)

`steem.initialize(config: ["api": "https://api.steemit.com"])`

Also inside your AppDelegate you should setup the OAuth Data (if you want to use it)
``` swift
steem.auth.setConfig(conf: [
            "client_id": "<% YOUR CLIENT ID %>",
            "client_secret": "<% YOUR CLIENT SECRET %>",
            "authorize_uri": "https://v2.steemconnect.com/oauth2/authorize",
            "token_uri": "https://v2.steemconnect.com/api/oauth2/token",
            "redirect_uris": ["testauthapp://oauth/callback"], // CHANGE TO YOUR REDIRECT_URI
            "scope": "login,offline,vote,comment,custom_json", // ADD MORE
            "should_Debug": true, // IF YOU WANT TO RECEIVE DEBUG MESSAGES & VERBOSE STYLE
])
```

The last step inside the AppDelegate is to make use of the applicationOpenURL function:
``` swift
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if "testauthapp" == url.scheme {
            steem.auth.handleRedirectURL(url: url)
            return true
        }
        return false
    }
```
Simply copy & paste it and change `testauthapp` to your scheme you use in your redirect_uris!

Now we want to tell our App it should listen for schemes with the name `testauthapp`, to do so open your `Info.plist` and add following code:
```
<key>CFBundleURLTypes</key>
<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Viewer</string>
			<key>CFBundleURLName</key>
			<string>testauthapp</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>testauthapp</string>
			</array>
		</dict>
</array>
```
#### SwiftyConnects 3 Classes
SwiftyConnects has 3 classes you can call from the Steem Class:
- Auth (Authorize)
- API (Fetch data)
- Broadcast (Send data)

#### Authorization & Revoking 
Use `authorize` to authorize the user and open the SteemConnect Login Page in Safari
```
steem.auth.authorize() { jsonResponse in
  print(jsonResponse)
}
```
`authorize` returns your user data, which can be used whether to check if the auth worked or to setup your user object. 

To revoke your token use
```
steem.auth.revoke { (success) in
}
```
**REMINDER:** To completely logout of SteemConnect one has to open SteemConnect on your Safari Browser and logout. Otherwise you can't switch accounts (this is an behaviour by steemconnect... BUT I already developing a multi account management for them)

If you want to check if an user is logged in without calling an endpoint use `steem.auth.isAuthorized()` 

**Methods**
```
public class Auth {

    public func setConfig(conf: NSDictionary)

    public func getConfig() -> NSDictionary

    public func isAuthorized() -> Bool

    public func revoke(callback: @escaping ((Bool) -> Swift.Void))

    public func handleRedirectURL(url: URL)

    public func me(callback: @escaping ((JSONString) -> Swift.Void))

    public func updateUserMetadata(userMetadata: JSONString, callback: @escaping ((JSONString) -> Swift.Void))

    public func authorize(callback: @escaping ((JSONString) -> Swift.Void))
}
```

#### Broadcasting
Broadcasting is used to send data to the blockchain, and requires a valid authorized account!

**Methods**
```
public class Broadcast {

    public func vote(voter: String, author: String, permlink: String, weight: Int, completion: ((JSONString) -> Swift.Void)?)

    public func reblog(account: String, author: String, permlink: String, completion: ((JSONString) -> Swift.Void)?)

    public func customJSON(account: String, json: JSONString, completion: ((JSONString) -> Swift.Void)?)

    public func follow(follower: String, following: String, completion: ((JSONString) -> Swift.Void)?)

    public func unfollow(unfollower: String, unfollowing: String, completion: ((JSONString) -> Swift.Void)?)

    public func ignore(follower: String, following: String, completion: ((JSONString) -> Swift.Void)?)

    public func claimRewardBalance(account: String, rewardSBD: String, rewardSteem: String, rewardVests: Int, completion: ((JSONString) -> Swift.Void)?)

    public func comment(parentAuthor: String?, parentPermlink: String?, author: String, permlink: String, title: String, body: String, jsonMetadata: SwiftySteem.JSONMetadata, completion: ((JSONString) -> Swift.Void)?)
}
```
All Methods return a JSON / NSDictionary, to know what they return simply test it and print it out. 
If a method failed you can check if `response["error"]` is not nil, it will return the error.

#### API

```
public class Api {

    public func getTrendingTags(afterTag: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByTrending(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByCreated(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByActive(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByPayout(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByCashout(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByVotes(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByChildren(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByHot(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByFeed(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByBlog(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByComments(query: SwiftyConnect.QueryDiscussionsBy, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getBlock(blockNumber: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getBlockHeader(blockNumber: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getState(blockNumber: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getConfig(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDynamicGlobalProperties(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getChainProperties(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getFeedHistory(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getCurrentMedianHistoryPrice(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getHardforkVersion(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getNextScheduledHardfork(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getRewardFund(name: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getVestingDelegations(account: String, from: Int, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getKeyReferences(key: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getAccounts(accounts: [String], completion: ((Any?, Any?) -> Swift.Void)?)

    public func getAccountReferences(id: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func lookupAccountNames(accounts: [String], completion: ((Any?, Any?) -> Swift.Void)?)

    public func lookupAccounts(lowerBoundName: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getAccountCount(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getConversionRequests(account: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getAccountHistory(name: String, from: Int, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getOwnerHistory(account: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getRecoveryRequest(account: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getOrderBook(limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getOpenOrders(name: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getLiquidityQueue(name: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getTransaction(trxId: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getTransactionHex(trx: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getRequiredSignatures(trx: Int, availableKeys: [String], completion: ((Any?, Any?) -> Swift.Void)?)

    public func getPotentialSignatures(trx: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func verifyAuthority(trx: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func verifyAccountAuthority(name: String, key: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getActiveVotes(author: String, permlink: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getAccountVotes(account: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getContent(author: String, permlink: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getContentReplies(author: String, permlink: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getDiscussionsByAuthorBeforeDate(author: String, startPermlink: String, beforeDate: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getRepliesByLastUpdate(author: String, permlink: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getWitnesses(witnessIds: [String], completion: ((Any?, Any?) -> Swift.Void)?)

    public func getWitnessByAccount(name: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getWitnessesByVote(from: Int, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func lookupWitnessAccounts(lowerBoundName: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getWitnessCount(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getActiveWitnesses(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getMinerQueue(completion: ((Any?, Any?) -> Swift.Void)?)

    public func getFollowers(name: String, start: String, type: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getFollowCount(account: String, completion: ((Any?, Any?) -> Swift.Void)?)

    public func getFollowing(name: String, start: String, type: String, limit: Int, completion: ((Any?, Any?) -> Swift.Void)?)
}
```

All Methods return a NSDictionary.

**Reminder:** There is a lack of Unit Tests for the API, currently I do not know if every method works as expected ! But try it out yourself, I guess most of them will work !

# Roadmap
- V0.2:
  - Full API Unit Tests
  - Full API Documentation
- V1.0:
  - Full Documentation
  - Sign Actions
  
# Known Errors
```
["error-code": 500, "error": "internal server error"]
```
This basically means your data is wrong or your action is invalid (e.g voting a post you already have voted)
