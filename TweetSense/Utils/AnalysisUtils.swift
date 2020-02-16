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
    var analyzedCategoriesArray: [ToneCategory] = []
    
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
            self.analyzedCategoriesArray = []

            print(tones)
            
            
//
//            // Loop through document tones
//            for documentTone in categories {
//                // Set tone category parameters
//                let toneCategoryId = documentTone.categoryID
//                let toneCategoryName = documentTone.categoryName
//                let tones = documentTone.tones
//                // Create new tone category with information provided by document tone
//                let newToneCategory = try! JSONDecoder().decode(ToneCategory.self, from: response)
//                // Add new tone category to array
//                self.analyzedCategoriesArray.append(newToneCategory)
//            }
            
        }
    }

    
    
    
}
