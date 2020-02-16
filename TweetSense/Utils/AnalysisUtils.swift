//
//  TwitterUtils.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import SwiftyJSON

public class AnalysisUtils {
    static let shared = AnalysisUtils()
    var analyzedCategoriesArray: [ToneCategory] = []
    
    func callWatson(toAnalyze: String, completion: @escaping (Double?) -> ()) {
        
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
            self.analyzedCategoriesArray = []
            
            print(tones)
            
        }
    }
    
    func getSentimentScore(toAnalyze: String, completion: @escaping (Double?) -> ()) {
        
        let yuh = """
        {
        "document":{
        "type":"PLAIN_TEXT",
        "content":"\(toAnalyze)"
        },
        "encodingType": "UTF8"
        }
        """
       
        guard let url = URL(string: "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyAvagB9vuqGp00y8bYl7lgqQmDoBtkioGM"),
            let payload = yuh.data(using: .utf8) else {
                return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if let str = String(data: data, encoding: .utf8) {
                print(str)
                completion(nil)
            }
        }.resume()
        
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    
}
