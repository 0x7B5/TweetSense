//
//  MainTabBarController.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let mainVC = MainVC()
        //all the cool kids have no titles for their tab bars
        mainVC.tabBarItem.title = "Dashboard"
        mainVC.tabBarItem.image = UIImage(named: "search")
        
        let searchVC = SearchVC()
        searchVC.tabBarItem.title = "Search"
        searchVC.tabBarItem.image = UIImage(named: "search")
        
        let controllers = [mainVC, searchVC]
        self.viewControllers = controllers.map{ UINavigationController.init(rootViewController: $0)}
    }
    
    
}
