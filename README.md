# SwiftyConnect
SteemConnect Library for iOS / Swift

![swifty.png](https://steemitimages.com/DQmbskq3tikiLX1g3spZxrGqEkn5yx7nZv6EvCC2nvgCWxK/swifty.png)

## Current Version: 0.1.3

## Installation
**Carthage**

Installation via Carthage is easy enough:
```
github "caspernikus/SwiftyConnect" ~> 0.1.3
```
(When building SwiftyConnect the lib OAuth2 is also builded, there is no need to add OAuth2 inside your project, since SwiftyConenct contains OAuth2!)

### How To Use

#### Installation
**Carthage**
```
github "caspernikus/SwiftyConnect" ~> 0.1.3
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
The naming and usage of the API is the same as in SteemJS, check out their docu for all methods!
When fully tests are done I will provide a full documentation myself.

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
