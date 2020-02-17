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
    var longText = ""
    var googleText = ""
    
    func setUpAnalysisPage(username: String, isUser: Bool, with: [Tweet], completion: @escaping (AnalysisPage?) -> ()) {
        
        var mag = 0.0
        var sentiment = 0.0
        var analysisPage: AnalysisPage
        
        for _ in 0..<100 {
            longText = longText + "." + with[Int.random(in: 0 ..< with.count)].text
        }
        
        for _ in 0..<200 {
            googleText = googleText + "." + with[Int.random(in: 0 ..< with.count)].text
        }
        
        let sentimentScore = getSentimentScore(toAnalyze: googleText, completion: {score,magnitude  in
            sentiment = score
            mag = magnitude
            self.callWatson(completion: { toneScores  in
                self.getPersonality(toAnalyze: self.longText, completion: {
                    pers in
                   
                    let useruser = AnalysisPage(name: username, isUser: isUser, tweets: with, sentimentScore: sentiment, toneScores: toneScores, magnitude: mag, personality: pers!)
                    completion(useruser)
                })
            })
            
           
        })
        
        
        
        
    }
    
    func getPersonality(toAnalyze: String, completion: @escaping (Profile?) -> ()) {
       
        let version = "2020-02-15" // use today's date for the most recent version
        let personalityInsights = PersonalityInsights(version: version, authenticator: WatsonBasicAuthenticator(username: "apikey", password: ""))

        let content = ProfileContent.text(toAnalyze)
        personalityInsights.profile(profileContent: content) { response, error in
            if let error = error {
                print(error)
                completion(nil)
            }
            guard let profile = response?.result else {
                print("Failed to generate profile")
                completion(nil)
                return
            }
            completion(profile)
            print("Personality")
            print(profile.personality)
            
            print("Needs")
            print(profile.needs)
0
            
            var yuhyuh = [Trait]()

            for i in profile.needs {
                if(i.percentile > 0.5) {
                    yuhyuh.append(i)
                }
            }

            let newnew = yuhyuh.sorted(by: { $0.percentile > $1.percentile })
            print(newnew)
            
            print("Values")
            print(profile.values)
            
        }
    }
    func callWatson(completion: @escaping ([Double]) -> ())  {
    
        var toneScores = [Double]()
        
        for _ in 0..<8 {
            toneScores.append(0.0)
        }
        
        #warning("Put today's date here")
        let version = "YYYY-MM-DD" // use today's date for the most recent version
        let toneAnalyzer = ToneAnalyzer(version: "2020-02-15", authenticator: WatsonBasicAuthenticator(username: "apikey", password: "-J"))
        
        let input = ToneInput(text: longText)
        
        toneAnalyzer.tone(toneContent: .toneInput(input), sentences: false) { response, error in
            if let error = error {
                print(error)
            }
            guard let tones = response?.result else {
                print("Failed to analyze the tone input")
                return
            }
            self.analyzedCategoriesArray = []
            
            //print(tones)
           
            
            var myCount = 0
            for i in tones.documentTone.tones! {
                switch i.toneID {
                case "joy":
                    toneScores[1] = toneScores[1] + i.score
                case "fear":
                    toneScores[0] = toneScores[0] + i.score
                case "sadness":
                    toneScores[3] = toneScores[3] + i.score
                case "anger":
                    toneScores[2] = toneScores[2] + i.score
                case "tenative":
                    toneScores[4] = toneScores[4] + i.score
                case "confident":
                    toneScores[5] = toneScores[5] + i.score
                case "analytical":
                    toneScores[6] = toneScores[6] + i.score
                default:
                    break
                }
                myCount += 1
            }
            
            
            
            for i in 0..<8{
                toneScores[i] = toneScores[i]/Double(myCount)
            }
            print(toneScores)
        }
         completion(toneScores)
    }
    
    func getSentimentScore(toAnalyze: String, completion: @escaping (Double,Double) -> ()) {
        
        var parseAnalyzed = toAnalyze.replacingOccurrences(of: "\\", with: "")
        var parseAnalyzed2 = parseAnalyzed.replacingOccurrences(of: "\n", with: "")
        var parseAnalyzed3 = parseAnalyzed2.replacingOccurrences(of: "\"", with: "")
        var parseAnalyzed4 = parseAnalyzed3.replacingOccurrences(of: ".\"", with: "")
        let yuh = """
        {
        "document":{
        "type":"PLAIN_TEXT",
        "content":"\(parseAnalyzed4)"
        },
        "encodingType": "UTF8"
        }
        """
       
        guard let url = URL(string: "https://language.googleapis.com/v1/documents:analyzeSentiment?key="),
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
            
            do {
                let yuh = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                print(yuh)
                for (key, value) in yuh! {
                    if(key == "documentSentiment") {
                        do {
                            let myVar = value as? [String: Double]
                            print(myVar!["score"], myVar!["magnitude"])
                            
                            completion(myVar!["score"]!,myVar!["magnitude"]!)
                        } catch {
                            completion(0.0,0.0)
                        }
                        
                    }
                   
                }
            } catch {
                print(error.localizedDescription)
                completion(0.0,0.0)
            }
            
//            if let str = String(data: data, encoding: .utf8) {
//                print(str)
//                completion(nil)
//            }
        }.resume()
        
    }
    
    
    
}
