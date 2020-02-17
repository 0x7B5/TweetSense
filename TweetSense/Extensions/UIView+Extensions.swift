//
//  UIView+Extensions.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/15/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        self.layer.shadowPath =
              UIBezierPath(roundedRect: self.bounds,
              cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 1
        self.layer.masksToBounds = false
    }
}

extension UIButton {
    func roundDatHoe() {
        self.layer.cornerRadius = 10
    }
    func addBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}


import Foundation

extension Array {

  func randomElement() -> Element?  {
     if isEmpty { return nil }
     return self[Int(arc4random_uniform(UInt32(self.count)))]
  }
}
