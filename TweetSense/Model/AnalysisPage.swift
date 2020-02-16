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
    let photoUrl: String
    var senseScore: Double
    let isUser: Bool
    
    let tweets: [Tweet]
    //Sentiment Score
    let sentimentScore: Double
    let sentimentColor: UIColor
    
    //Language Style
    let languageScores: [Int]
    let languageColor: UIColor

    //Emotion
    let emotionScores: [Int]
    let emotionColor: UIColor
    
    //Social Tendencies
    let socialTendencies: [Int]
    let socialColor: UIColor

    init(name:String, photoUrl:String, senseScore:Double, isUser:Bool, tweets:[Tweet], sentimentScore:Double, sentimentColor:UIColor, languageScores:[Int], languageColor:UIColor, emotionScores:[Int], emotionColor:UIColor, socialTendencies:[Int], socialColor:UIColor) {
        self.name = name
        self.photoUrl = photoUrl
        self.senseScore = senseScore
        self.isUser = isUser
        self.tweets = tweets
        self.sentimentScore = sentimentScore
        self.sentimentColor = sentimentColor
        self.languageScores = languageScores
        self.languageColor = languageColor
        self.emotionScores = emotionScores
        self.emotionColor = emotionColor
        self.socialTendencies = socialTendencies
        self.socialColor = socialColor
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
