//
//  SearchVC.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class SearchVC: UIViewController, UITextFieldDelegate {
    
    var timelineVC: TimelineViewer!
    
    @IBOutlet weak var tweetTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTF.delegate = self
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        handleText()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func handleText() {
        if tweetTF.text != nil && tweetTF.text != "" {
            timelineVC = TimelineViewer()
            timelineVC.passingTwitterName = tweetTF.text
            let navC = UINavigationController(rootViewController: timelineVC)
            self.present(navC, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Username not found", message: "Please Enter Valid Username", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        tweetTF.text = ""
    }
    
    func analyzeTweets() {
        
        let counter = timelineVC.countOfTweets()
        print("There are " + String(counter) + " loaded tweets.\n\n")
        for i in 0..<counter {
            let tweet = timelineVC.tweet(at: Int(i))
            print(tweet.author.formattedScreenName + ": " + tweet.text)
        }
        
    }
    
}
