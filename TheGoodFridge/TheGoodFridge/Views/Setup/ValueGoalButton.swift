//
//  ValueButton.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/6/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ValueGoalButton: UIButton {

    var selectedImage = UIImage(named: "ValueButtonHighlighted")
    var unselectedImage = UIImage(named: "ValueButtonNormal")
    
    let valueGoalView = ValueGoalView()
    var buttonWidth: CGFloat = 0.0
    
    required init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setBackgroundImage(unselectedImage, for: .normal)
        addSubview(valueGoalView)
        bringSubviewToFront(valueGoalView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImages(selected: UIImage?, unselected: UIImage?) {
        selectedImage = selected
        unselectedImage = unselected
        setBackgroundImage(unselectedImage, for: .normal)
    }
    
    func isSelected() -> Bool {
        return currentBackgroundImage == selectedImage
    }
    
    func toggle() {
        let backgroundImage = isSelected() ? unselectedImage : selectedImage
        setBackgroundImage(backgroundImage, for: .normal)
    }
    
    func setSelected() {
        setBackgroundImage(selectedImage, for: .normal)
    }
    
    func setText(to value: String) {
        valueGoalView.label.text = value
    }
    
    func setIssueText(to value: String) {
        valueGoalView.setIssueText(to: value, buttonWidth: buttonWidth)
    }
    
    func setImage(to image: UIImage?) {
        valueGoalView.imageView.image = image
    }
    
    private func setupLayout() {
        
        let constraints = [
            valueGoalView.topAnchor.constraint(equalTo: topAnchor),
            valueGoalView.leadingAnchor.constraint(equalTo: leadingAnchor),
            valueGoalView.bottomAnchor.constraint(equalTo: bottomAnchor),
            valueGoalView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.height / 5
    }
    
}

class ValueGoalView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Bold", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var labelHeightConstraint = label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height)
    
    let issueFont = UIFont(name: "Amiko-Bold", size: 12)
    let margin: CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setIssueText(to value: String, buttonWidth: CGFloat) {
        if label.font != issueFont {
            label.font = issueFont
        }
//        let attrString = value as NSString
//        let strSize = attrString.size(withAttributes: [NSAttributedString.Key.font: issueFont!])
//        if value == "Health Management" {
//            print(strSize.width)
//            print(buttonWidth - 2 * margin)
//        }
        if value.count > Int(buttonWidth * 0.12) {
            var str = ""
            var newline = false
            for ch in value {
                if ch == " " && !newline {
                    newline = true
                    str += "\n"
                } else {
                    str += String(ch)
                }
            }
            label.text = str
            return
        }
        label.text = value
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let constraints = [
            //labelHeightConstraint,
            label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            //imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -margin / 2),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: margin / 2),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin / 2),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
