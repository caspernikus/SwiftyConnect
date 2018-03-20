//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import SwiftySteem

let steem = Steem.sharedInstance

steem.initialize(config: ["api": ""])

let query = QueryDiscussionsBy(tag: "s", start_author: "dd", start_permlink: "d", limit: 1)

