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
    
    //Buttons
    
    @IBOutlet weak var userButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextfield()
        userButton.roundDatHoe()
        userButton.addBorder()
        
        tweetTF.delegate = self
    }
    
    
    func tweetTFShouldReturn(_ tweetTF: UITextField) -> Bool {
        tweetTF.resignFirstResponder()
        handleText()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func handleText() {
        if tweetTF.text != nil && tweetTF.text != "" {
            let tempText = tweetTF.text!
            if (Constants.userSearch == false) {
                
            } else {
                getUserTweets(username: tempText, completion: { tweets in
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
    
    func makePrefix() {
        
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
        tweetTF.returnKeyType = UIReturnKeyType.done
        tweetTF.clearButtonMode = UITextField.ViewMode.whileEditing
        tweetTF.autocapitalizationType = .none
        tweetTF.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tweetTF.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
}
