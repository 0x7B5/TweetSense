//
//  TwitterUtils.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation


public class AnalysisUtils {
    static let shared = AnalysisUtils()
    
//    let toneAnalyzer = ToneAnalyzer(
//        username: "your-username-here",
//        password: "your-password-here",
//        version: "yyyy-mm-dd"
//    )
//    toneAnalyzer.serviceURL = "https://gateway-fra.watsonplatform.net/tone-analyzer/api"
    
    
    func callWatson() {
        
        #warning("Put today's date here")
        let inputText = """
I hate these new features On #ThisPhone after the update.
I hate #ThisPhoneCompany products, you'd have to torture me to get me to use #ThisPhone.
The emojis in #ThisPhone are stupid.
#ThisPhone is a useless, stupid waste of money.
#ThisPhone is the worst phone I've ever had - ever 😠.
#ThisPhone another ripoff, lost all respect SHAME.
I'm worried my #ThisPhone is going to overheat like my brother's did.
#ThisPhoneCompany really let me down... my new phone won't even turn on.
"""
        let version = "YYYY-MM-DD" // use today's date for the most recent version
        let toneAnalyzer = ToneAnalyzer(version: "2020-02-15", authenticator: WatsonBasicAuthenticator(username: "apikey", password: "OiiD65lKNoiE0kBdlApvIi4uE66hmxqKlF5qxwG4pl-J"))

        let input = ToneInput(text: inputText)
        toneAnalyzer.tone(toneContent: .toneInput(input)) { response, error in
            if let error = error {
                print(error)
            }
            guard let tones = response?.result else {
                print("Failed to analyze the tone input")
                return
            }
            print(tones)
        }
    }

    
    
    
}
