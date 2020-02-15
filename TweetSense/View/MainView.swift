//
//  MainView.swift
//  TweetSense
//
//  Created by Vlad Munteanu on 2/14/20.
//  Copyright © 2020 Vlad Munteanu. All rights reserved.
//

import Foundation
import SnapKit

public class MainView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.frame = CGRect.zero
        //backgroundColor = Constants.mainBGColor
        initializeUI()
        createConstraints()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        addSubview(yuh)
    }
    
    public func createConstraints() {
        yuh.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
    
    let yuh: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        return view
    }()
}
