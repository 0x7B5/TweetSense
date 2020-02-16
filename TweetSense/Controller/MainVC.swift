//
//  ViewController.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/14/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import UIKit
import PopupDialog

class MainVC: UIViewController {
    @IBOutlet var viewCollection: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in viewCollection {
            i.roundIt()
           
        }
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        // Prepare the popup assets
        let title = "Search Type"
        let message = "Do you want to search for a user or topic?"
        let image = UIImage(named: "twitterLogin")

        // Create the dialog
        let popup = PopupDialog(title: title, message: message, image: image)

        // Create buttons
        let buttonOne = CancelButton(title: "CANCEL") {
            print("You canceled the car dialog.")
        }

        // This button will not the dismiss the dialog
        let buttonTwo = DefaultButton(title: "USER SEARCH", dismissOnTap: false) {
            Constants.userSearch = true
            self.performSegue(withIdentifier: "goToSearch", sender: self)
        }

        let buttonThree = DefaultButton(title: "TOPIC SEARCH", height: 80) {
            Constants.userSearch = false
            self.performSegue(withIdentifier: "goToSearch", sender: self)
        }
        
        popup.addButtons([buttonTwo, buttonThree, buttonOne])

        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
}

