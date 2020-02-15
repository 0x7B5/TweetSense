//
//  TimelineViewer.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class TimelineViewer: TWTRTimelineViewController {
    
    public var passingTwitterName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hey")
        
        let client = TWTRAPIClient.withCurrentUser()
        self.dataSource = TWTRUserTimelineDataSource(screenName: passingTwitterName, apiClient: client)
        
        self.title = "@" + passingTwitterName
        self.showTweetActions = false
        
    }
    
}
