//
//  ProfileVC.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class ProfileVC: UIViewController {
    
    var twitterProfilePicture: UIImage?
    
    
    @IBOutlet weak var profileUsername: UILabel!
    @IBOutlet weak var profileSenseScore: UILabel!
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet var viewCollection: [UIView]!
    /*
    **TAG GUIDE*
    Sentiment View
        Sentiment Score: 11
            
    Language Style View
        Analytical Score: 21
        Confident Score: 22
        Tenative Score: 23
     
     Emotion View
        Fear: 31
        Joy: 32
        Disgust: 33
        Anger: 34
        Sadness: 35
     
     Social Tendencies
        Agreeableness: 41
        Conscientiousness: 42
        Extroversion: 43
        Emotion Range: 44
        Openess: 45
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.setRounded()
        setupUI()
    }
    
    
    @IBAction func backbuttonPressed(_ sender: Any) {
       triggerAlert()
    }
    
    
    func triggerAlert() {
        // Prepare the popup assets
        let title = "Exiting"
        let message = "Do you want to save this data to your dashboard?"
        #warning("Set this to profile image")
        let image = UIImage(named: "coloredPicasso")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        // Create buttons
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }
        
        // This button will not the dismiss the dialog
        let buttonTwo = DefaultButton(title: "SAVE", dismissOnTap: false) {
           
        }
        
        let buttonThree = DefaultButton(title: "DON'T SAVE", height: 80) {
             self.performSegue(withIdentifier: "backHomeFrom", sender: self)
        }
        
        popup.addButtons([buttonTwo, buttonThree, buttonOne])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    func setupUI() {
        for i in viewCollection {
            i.roundIt()
           // i.dropShadow()
        }
    }
    
    func setupColors() {
        
    }
    
}
