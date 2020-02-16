//
//  ViewController.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/14/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet var viewCollection: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in viewCollection {
            i.roundIt()
        }
    }


}

