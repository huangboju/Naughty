//
//  HeaderView.swift
//  AppStore
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: UIView {
    
    static let width = UIScreen.main.bounds.width
    static let padding: CGFloat = 15
    
    var makeThisTallerHeight: NSLayoutConstraint!
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Resizing Header"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()

    lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "This header can dynamically resize according to its contents."
        textLabel.numberOfLines = 0
        return textLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Add More Text", for: .normal)
        button.backgroundColor = UIColor(red: 245 / 255, green: 1, blue: 250 / 255, alpha: 1)
        return button
    }()
    
    lazy var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Make This Taller", for: .normal)
        button.backgroundColor = UIColor(red: 1, green: 182 / 255, blue: 193 / 255, alpha: 1)
        return button
    }()

    init(frame: CGRect, target: Any?, action: Selector, secondAction: Selector) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(textLabel)
        addSubview(button)
        addSubview(secondButton)
        
        titleLabel.backgroundColor = UIColor.red
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(self).offset(30)
            make.trailing.equalTo(self)
        }

        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.bottom.equalTo(button.snp.top).offset(-20)
        }

        button.addTarget(target, action: action, for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(34)
            make.width.equalTo(HeaderView.width - 60)
        }
        
        
        secondButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.height.equalTo(34)
            make.width.equalTo(HeaderView.width - 60)
            make.top.equalTo(button.snp.bottom).offset(20)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
        
        secondButton.constraints.forEach {
            if $0.firstAttribute == .height {
                makeThisTallerHeight = $0
            }
        }
        

        secondButton.addTarget(target, action: secondAction, for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
