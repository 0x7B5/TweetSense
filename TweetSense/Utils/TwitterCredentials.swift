//
//  TwitterCredentials.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

struct TwitterAccountCredentials {
   
    static let consumerKey = ""
    static let consumerSecret = ""
    static let concatenatedKeyAndSecret = consumerKey+":"+consumerSecret
    static func getBase64EncodedValue() -> String? {
        return concatenatedKeyAndSecret.base64Encoded
    }
}
public extension String {
    
    var base64Encoded: String? {
        let utf8 = self.data(using: .utf8)
        let base64 = utf8?.base64EncodedString()
        return base64
    }

}
