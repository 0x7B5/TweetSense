//
//  AnalysisPage.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit

struct AnalysisPage {
    let name: String
   // let photoUrl: String
   // var senseScore: Double
    let isUser: Bool
    
    let tweets: [Tweet]
    //Sentiment Score
    let sentimentScore: Double
    let magnitude: Double
   // let sentimentColor: UIColor
    
    //Values
    // let valuesScores: [Int]
    //let valuesColor: UIColor

    //Emotion
    let toneScores: [Double]
    
    let personality: Profile
   // let toneColor: UIColor
    
    //Social Tendencies
    //let socialTendencies: [Int]
    //let socialColor: UIColor
    
    func getPersonality() -> [String] {
        
        var yuhyuh = [Trait]()
        var tempy = [String]()
        
        for i in personality.personality {
            if(i.percentile > 0.5) {
                yuhyuh.append(i)
            }
        }

        let newnew = yuhyuh.sorted(by: { $0.percentile > $1.percentile })
        print(newnew)
        
        print("Personality Traits")
        print("-------------------")
        for i in 0..<newnew.count {
            
           
            print(newnew[i].name)
            print(newnew[i].percentile)
            print("")
        }
        
        print("Needs")
        print("-------------------")
        for i in personality.needs {
            print(i.name)
            print(i.percentile)
            tempy.append(i.name)
            tempy.append(String(i.percentile))
            print("")
        }
        
        print("Values")
        print("-------------------")
        for i in personality.values {
            print(i.name)
            print(i.percentile)
            print("")
        }
        
        return tempy
        
    }

    init(name:String, isUser:Bool, tweets:[Tweet], sentimentScore:Double, toneScores:[Double], magnitude:Double, personality: Profile) {
        self.name = name
       
        self.isUser = isUser
        self.tweets = tweets
        self.sentimentScore = sentimentScore

       
        self.toneScores = toneScores
       // self.toneColor = toneColor
        //self.socialTendencies = socialTendencies
       // self.socialColor = socialColor
        self.magnitude = magnitude
        self.personality = personality
    }
    
    
}


//    let analyticalScore: Int
//    let confidentScore: Int
//    let tenativeScore: Int
    
//    let fearScore: Int
//    let joyScore: Int
//    let disgustScore: Int
//    let angerScore: Int
//    let sadnessScore: Int

//    let agreeablenessScore: Int
//    let conscientiousnessScore: Int
//    let extroversionScore: Int
//    let emotionRangeScore: Int
//    let openessScore: Int
