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
    
    func getTopicTweets(topic: String, completion: @escaping ([Tweet]?) -> ()) {
        let loadingNotification = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Fetching Tweets"
        
        if let url = URL(string:("https://tweetsense-268300.appspot.com/topic/"+topic)) {
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
