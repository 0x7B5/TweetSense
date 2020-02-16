//
//  ProfileVC.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    var twitterProfilePicture: UIImage?
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.setRounded()
    }
}
