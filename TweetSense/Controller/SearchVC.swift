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
import Swifter


class SearchVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var tweetTF: UITextField!
    @IBOutlet weak var coveringView: UIView!
    private var usernamePrefix = NSMutableAttributedString(string: "@")
    
    //Buttons
    @IBOutlet weak var userButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTF.delegate = self
        setupUI()
    }
    
    func setupUI() {
        setupTextfield()
        userButton.roundDatHoe()
        userButton.addBorder()
        if (Constants.userSearch == true) {
            makePrefix()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tweetTF.becomeFirstResponder()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //This makes the new text black.
        tweetTF.typingAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        let protectedRange = NSMakeRange(0, 1)
        let intersection = NSIntersectionRange(protectedRange, range)
        if intersection.length > 0 {
            if (Constants.userSearch == false) {
                return true
            }
            return false
        }
        return true
    }
    
    func makePrefix() {
        let attributedString = NSMutableAttributedString(string: "@")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: NSMakeRange(0,1))
        tweetTF.attributedText = attributedString
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tweetTF.resignFirstResponder()
        print("return return")
        handleText()
        return true
    }
    
    
    @IBAction func analyzeButtonPressed(_ sender: Any) {
        handleText()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func handleText() {
        if tweetTF.text != nil && tweetTF.text != "" {
            let tempText = tweetTF.text!
            print(tempText)
            if (Constants.userSearch == false) {
                getTopicTweets(topic: tempText, completion: { tweets in
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                })
            } else {
                let newTempText = tempText.substring(from: 1)
                print(newTempText)
                getUserTweets(username: newTempText, completion: { tweets in
                    self.performSegue(withIdentifier: "toProfile", sender: self)
                })
            }
            
        } else {
            let alert = UIAlertController(title: "Username not found", message: "Please Enter Valid Username", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
        tweetTF.text = ""
    }
    
    func getUserTweets(username: String, completion: @escaping ([Tweet]?) -> ()) {
        UIApplication.shared.beginIgnoringInteractionEvents()
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
                        var tweetText = i["Text"] as! String
                        print(tweetText)
                        
                        if (tweetText.contains("RT")) {
                            if let range = tweetText.range(of: ": ") {
                                let phone = tweetText[range.upperBound...]
                                tweetText = String(phone)
                            }
                        }
                        
                        if (tweetText.contains("https://")) {
                            let tempArray = tweetText.components(separatedBy: " ")
                            tweetText = ""
                            for i in tempArray {
                                if !(i.contains("https://")) {
                                    if (i.count == 0) {
                                        tweetText = tweetText + i
                                    } else {
                                        tweetText = tweetText + " " + i
                                    }
                                    
                                }
                            }
                        }
                        
                        userTweets.append(Tweet(date: itemDate, text: tweetText))
                    }
                    
                    print(userTweets)
                    DispatchQueue.main.async { () -> Void in
                        loadingNotification.hide(animated: true)
                        UIApplication.shared.endIgnoringInteractionEvents()
                        completion(userTweets)
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                    DispatchQueue.main.async { () -> Void in
                        loadingNotification.hide(animated: true)
                        UIApplication.shared.endIgnoringInteractionEvents()
                        completion(nil)
                    }
                }
                
                
            }.resume()
        }
    }
    
    func getTopicTweets(topic: String, completion: @escaping ([Tweet]?) -> ()) {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Fetching Tweets"
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        var userTweets = [Tweet]()
        
        
        let swifter = Swifter(consumerKey: Constants.TWITTER_CONSUMER_KEY, consumerSecret: Constants.TWITTER_CONSUMER_SECRET, appOnly: true)
        
        swifter.authorizeAppOnly(success: { (accessToken, response) -> Void in
            
            swifter.searchTweet(using: topic, geocode: "", lang: "en", locale: "", resultType: "", count: 300, until: "", sinceID: "2009-01-01", maxID: "", includeEntities: false, callback: "", tweetMode: .extended, success: { (statuses, searchMetadata) -> Void in
                
                for i in statuses.array! {
                    var tweetText = i["full_text"].string ?? ""
                    var tweetDate = i["created_at"].string ?? ""
                    
                    if tweetText == "" {
                        continue
                    }
                    
                    if tweetDate == "" {
                        continue
                    }
                    
                    if (tweetText.contains("RT")) {
                        if let range = tweetText.range(of: ": ") {
                            let phone = tweetText[range.upperBound...]
                            tweetText = String(phone)
                        }
                    }
                    
                    if (tweetText.contains("https://")) {
                        let tempArray = tweetText.components(separatedBy: " ")
                        tweetText = ""
                        for i in tempArray {
                            if !(i.contains("https://")) {
                                if (i.count == 0) {
                                    tweetText = i
                                } else {
                                    tweetText = tweetText + " " + i
                                }
                                
                            }
                        }
                    }
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    if let date = formatter.date(from: tweetDate) {
                        tweetDate = formatter.string(from: date)
                    }
                    
                    
                    print(tweetText)
                    print(tweetDate)
                    userTweets.append(Tweet(date: tweetDate, text: tweetText))
                    print("____")
                    DispatchQueue.main.async { () -> Void in
                        loadingNotification.hide(animated: true)
                        UIApplication.shared.endIgnoringInteractionEvents()
                        completion(userTweets)
                    }
                }
                
            }) { (error) -> Void in
                print(error)
                DispatchQueue.main.async { () -> Void in
                    loadingNotification.hide(animated: true)
                    UIApplication.shared.endIgnoringInteractionEvents()
                    completion(nil)
                }
            }
            print("\(response)")
        }, failure: { (error) -> Void in
            print(error)
            DispatchQueue.main.async { () -> Void in
                loadingNotification.hide(animated: true)
                UIApplication.shared.endIgnoringInteractionEvents()
                completion(nil)
            }
        })
    }
    
    func setupTextfield() {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        var attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        
        if (Constants.userSearch == false) {
            attributedPlaceholder = NSAttributedString(string: "Topic", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle, NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)])
        }
        tweetTF.attributedPlaceholder = attributedPlaceholder
        //tweetTF.placeholder = "Username"
        tweetTF.font = UIFont.systemFont(ofSize: 42, weight: UIFont.Weight(rawValue: 1.0))
        tweetTF.adjustsFontSizeToFitWidth = true
        //tweetTF.borderStyle = UItweetTF.BorderStyle.roundedRect
        tweetTF.textAlignment = .center
        tweetTF.autocorrectionType = UITextAutocorrectionType.no
        tweetTF.keyboardType = UIKeyboardType.default
        //tweetTF.returnKeyType = UIReturnKeyType.done
        tweetTF.clearButtonMode = UITextField.ViewMode.whileEditing
        tweetTF.autocapitalizationType = .none
        tweetTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tweetTF.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
}
