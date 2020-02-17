//
//  TopicProfileVC.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/16/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class TopicProfileVC: UIViewController {
    
    
    
    @IBOutlet weak var topicProfilePicture: UIImageView!
    @IBOutlet weak var topicName: UILabel!

    @IBOutlet var labels: [UILabel]!
   
    
    @IBOutlet weak var analytical: UILabel!
    
    @IBOutlet weak var confidenceLabel: UILabel!
    
    @IBOutlet weak var tenativeLabel: UILabel!
    
    
    @IBOutlet weak var sentimentLabel: UILabel!
    
    @IBOutlet weak var magnitudeLabel: UILabel!
    
    var currentTopic: AnalysisPage? = nil
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        if (currentTopic == nil) {
            errorMessage()
        }
        
        setupUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (currentTopic == nil) {
            errorMessage()
        }
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
        topicProfilePicture.setRounded()
//        for i in viewCollection {
//            i.roundIt()
//            // i.dropShadow()
//        }
        
        for i in 0..<5 {
            labels[i].text = String(currentTopic!.toneScores[i])
        }
        sentimentLabel.text = String(currentTopic!.sentimentScore)
        magnitudeLabel.text = String(currentTopic!.magnitude)
        analytical.text = String(currentTopic!.toneScores[4])
        confidenceLabel.text = String(currentTopic!.toneScores[5])
        tenativeLabel.text = String(currentTopic!.toneScores[6])
        topicName.text = String(currentTopic!.name)
    }
    
    func errorMessage() {
        // Prepare the popup assets
        let title = ""
        let message = "Something went wrong, lets try that again."
        
        let image = UIImage(named: "error")
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)
        
        
        let buttonTwo = DefaultButton(title: "GO HOME", dismissOnTap: false) {
            self.performSegue(withIdentifier: "backHomeFrom", sender: self)
        }
        
        popup.addButtons([buttonTwo])
        
        // Present dialog
        self.present(popup, animated: true, completion: {
            self.performSegue(withIdentifier: "backHomeFrom", sender: self)
        })
    }
    
}
