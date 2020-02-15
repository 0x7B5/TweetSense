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
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        initializeUI()
        createConstraints()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeUI() {
        addSubview(backgroundImg)
        addSubview(yuh)
        addSubview(yuh2)
        addSubview(mainText)
        addSubview(searchButton)
    }
    
    public func createConstraints() {
        
        backgroundImg.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        mainText.snp.makeConstraints{
            $0.centerY.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview().multipliedBy(0.6)
        }
        
        yuh.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(yuh.snp.width).multipliedBy(1.4)
            // $0.centerX.equalToSuperview().multipliedBy(0.5)
            $0.left.equalTo(mainText.snp.left)
            $0.centerY.equalToSuperview()
        }
        
        yuh.dropShadow()
        yuh2.dropShadow()
        
        yuh2.snp.makeConstraints{
            $0.width.equalToSuperview().multipliedBy(0.4)
            $0.height.equalTo(yuh.snp.width).multipliedBy(1.4)
            $0.centerX.equalToSuperview().multipliedBy(1.5)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints{
            $0.bottom.equalTo(mainText.snp.bottom)
            $0.centerX.equalToSuperview().multipliedBy(1.8)
            
        }
        
    }
    
    lazy var peopleCards = [UIView]()
    lazy var yuh = self.createSquare()
    lazy var yuh2 = self.createSquare()
    
    let mainText: UILabel = {
        let text = UILabel()
        text.text = "Dashboard"
        text.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        text.textColor = #colorLiteral(red: 0.1994101318, green: 0.2145992959, blue: 0.2358524935, alpha: 1)
        text.textAlignment = .left
        return text
    }()
    
    let backgroundImg: UIImageView = {
        let temp = UIImageView()
        temp.image = Constants.mainBackground
        return temp
    }()
    
    public let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"search"), for: .normal)
        return button
    }()
    
    public func createSquare() -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
    }
    
    
}
