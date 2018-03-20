//
//  Accounts.swift
//  SwiftySteem
//
//  Created by Benedikt Veith on 22.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation

struct GetAccounts: Codable {
    let jsonrpc: String
    let id: Int
    let method: String
    let params: [[String]]
}
