//
//  HttpClient.swift
//  SwiftySteem
//
//  Created by Benedikt Veith on 20.02.18.
//  Copyright © 2018 benedikt-veith. All rights reserved.
//

import Foundation

class HttpClient {
    
    var api : String!
    
    init(api: String) {
       self.api = api
    }
    
    func getData(url: String, completion:((Any?, _ response: Any?) -> Void)?) {
        let urlCom = URLComponents(string: url)?.url
        
        var request = URLRequest(url: urlCom!)
        request.httpMethod = "GET"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!, nil)
                return
            }
            
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                let jsonResult = utf8Representation.toJSON()!

                if let result = jsonResult as? [String: Any] {
                    if let error = result["error"] {
                        completion?(error, nil);
                        return;
                    }
                    
                    completion?(nil, result);
                    return
                }
                
                if let result = jsonResult as? [Any] {
                    completion?(nil, result[0]);
                    return
                }

            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    func useEndpoint(jsonData: Data, completion:((Any?, _ response: Any?) -> Void)?) {
        let url = URLComponents(string: api)?.url

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"

        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers

        request.httpBody = jsonData

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                completion?(responseError!, nil)
                return
            }

            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                
                let result = utf8Representation.toJSON()! as! NSDictionary
                
                if let error = result["error"] {
                    completion?(error, nil);
                    return;
                }
                
                completion?(nil, result);
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
}




