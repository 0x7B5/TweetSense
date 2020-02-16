//
//  UIImageView+Extensions.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
   func setRounded() {
      let radius = self.frame.width / 2
      self.layer.cornerRadius = radius
      self.layer.masksToBounds = true
   }
}

extension UIView {
    func roundIt() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
}
