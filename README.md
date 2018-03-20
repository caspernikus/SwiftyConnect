# SwiftyConnect
SteemConnect Library for iOS / Swift

![](https://steemitimages.com/DQmXivu44ipw8FSyvnRHFQChzJYiteZjWTvXJdLDWtyikvS/wallpaper.png)

## Current Version: 0.1

## Installation
**Carthage**

Installation via Carthage is easy enough:
```
github "caspernikus/SwiftyConnect" ~> 0.1.2
```

## How To Use ?
In your AppDelegate.swift initialize Steem and set the auth config:
```
steem.initialize(config: ["api": "https://api.steemit.com"])
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

After that you are good to go to use all broadcast / auth methods !

API Methods work directly after initializing Steem.

If you want to know if the user is authorized / logged in, use:
`steem.auth.isAuthorized()` 

### Auth Flow
Use `authorize` to authorize the user and open the SteemConnect Login Page in Safari
```
steem.auth.authorize() { jsonResponse in
  print(jsonResponse)
}
```
--> Returns the same data as `steem.auth.me()`, so you can instanstly create your User

**AppDelegate**

```
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if "testauthapp" == url.scheme {
            steem.auth.handleRedirectURL(url: url)
            return true
        }
        return false
}
```
is needed to allow redirection back to your app - the scheme should be the same as in your redirect uri `testauthapp://oauth/callback`.

**Info.plist**

You need to declare also your scheme inside Info.plist
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

**Revoke**

Revoke tokens with
```
steem.auth.revoke { (success) in
}
```

To compeletly logout / disable auto login via SteemConnect, you need to clear your Safari localStorage inside the Safari Settings. 

**PLEASE KEEP IN MIND THAT YOUR TOKENS ARE STORED DIRECTLY IN THE KEYCHAIN**

# SDK Methods
## Broadcast
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

## Auth
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

# Roadmap
- V0.2:
  - Full API Unit Tests
  - Full API Documentation
- V1.0:
  - Full Documentation
  - Sign Actions
