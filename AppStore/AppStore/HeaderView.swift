//
//  HeaderView.swift
//  AppStore
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    static let width = UIScreen.main.bounds.width
    static let padding: CGFloat = 15
    
    var makeThisTallerHeight: NSLayoutConstraint!
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: padding, y: 20, width: width - 2 * padding, height: 22))
        label.text = "Add Resizing Header"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Add More Text", for: .normal)
        button.backgroundColor = UIColor(red: 245 / 255, green: 1, blue: 250 / 255, alpha: 1)
        return button
    }()
    
    private lazy var secondButton: UIButton = {
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
        
        
        let top = curry { (item: UIView, toItem: UIView) in NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1.0, constant: 20) }
        let width = curry { (item: UIView) in NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: HeaderView.width - 2 * HeaderView.padding) }
        let left = curry { (item: UIView, toItem: UIView) in NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier:1.0, constant: 20) }
        let right = curry { (item: UIView, toItem: UIView) in NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1.0, constant: -20) }


        textLabel.text = "This header can dynamically resize according to its contents."
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let textLabelWidth = width(textLabel)
        textLabel.addConstraints([textLabelWidth])
        let textLabelLeft = left(textLabel)(self)
        let textLabelTop = top(textLabel)(titleLabel)
        let bottom = NSLayoutConstraint(item: textLabel, attribute: .bottom, relatedBy: .equal, toItem: button, attribute: .top, multiplier: 1.0, constant: -20)
        textLabel.superview!.addConstraints([textLabelLeft, textLabelTop, bottom])

        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonTop = top(button)(textLabel)
        let buttonRight = right(button)(self)
        let buttonLeft = left(button)(self)
        button.superview!.addConstraints([buttonTop, buttonLeft, buttonRight])
        button.addTarget(target, action: action, for: .touchUpInside)


        secondButton.translatesAutoresizingMaskIntoConstraints = false
        makeThisTallerHeight = NSLayoutConstraint(item: secondButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: 34)
        let secondButtonTop = top(secondButton)(button)
        let secondButtonRight = right(secondButton)(self)
        let secondButtonLeft = left(secondButton)(self)
        secondButton.addConstraints([makeThisTallerHeight])
        secondButton.superview!.addConstraints([secondButtonTop, secondButtonRight, secondButtonLeft])

        secondButton.addTarget(target, action: secondAction, for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
