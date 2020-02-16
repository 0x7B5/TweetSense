//
//  SearchVC.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD


class SearchVC: UIViewController, UITextFieldDelegate {
    
    
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
            let tempText = tweetTF.text!
            getTweets(username: tempText, completion: { tweets in
                self.performSegue(withIdentifier: "toProfile", sender: self)
            })
        } else {
            let alert = UIAlertController(title: "Username not found", message: "Please Enter Valid Username", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        tweetTF.text = ""
    }
    
    func getTweets(username: String, completion: @escaping ([Tweet]?) -> ()) {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Fetching Tweets"
        
        if let url = URL(string:("https://tweetsense-268300.appspot.com/tweets/"+username)) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                do {
                    var userTweets = [Tweet]()
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    //print(json)
                    
                    for i in json! {
                        let itemDate = i["Date"] as! String
                        let itemText = i["Text"] as! String
                        userTweets.append(Tweet(date: itemDate, text: itemText))
                    }

                    print(userTweets)
                    DispatchQueue.main.async { () -> Void in
                        loadingNotification.hide(animated: true)
                        completion(userTweets)
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                    DispatchQueue.main.async { () -> Void in
                        loadingNotification.hide(animated: true)
                        completion(nil)
                    }
                }
                
                
            }.resume()
        }
    }
    
}
