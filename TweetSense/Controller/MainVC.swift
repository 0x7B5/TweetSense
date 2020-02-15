//
//  ViewController.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/14/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    let mainView = MainView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

