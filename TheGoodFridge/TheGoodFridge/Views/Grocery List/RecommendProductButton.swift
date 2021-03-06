//
//  RecommendProductView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 6/26/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class RecommendProductButton: UIButton {

    let unselectedImage = UIImage(named: "RecommendProductUnselected")
    let selectedImage = UIImage(named: "RecommendProductSelected")
    var product: String?
    var attributedText: NSAttributedString?
    
//    lazy var selectButton: UIButton = {
//        let button = UIButton()
//        button.setTitleColor(.black, for: .normal)
//        button.titleLabel?.font = UIFont(name: "Amiko-Bold", size: 15)
//        button.setBackgroundImage(unselectedImage, for: .normal)
//        button.contentHorizontalAlignment = .leading
//        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 30.0, bottom: 0, right: 30.0)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont(name: "Amiko-Bold", size: 15)
        setBackgroundImage(unselectedImage, for: .normal)
        //        contentHorizontalAlignment = .leading
        //        titleEdgeInsets = UIEdgeInsets(top: 0, left: 30.0, bottom: 0, right: 30.0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(to text: String) {
        product = text
        setTitle(text, for: .normal)
    }
    
    func setAttributedText(to text: NSAttributedString) {
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        titleLabel?.numberOfLines = 0
        titleLabel?.lineBreakMode = .byWordWrapping
        attributedText = text
        setAttributedTitle(text, for: .normal)
    }
    
    func isSelected() -> Bool {
        return backgroundImage(for: .normal) == selectedImage
    }
    
    func reset() {
        setBackgroundImage(unselectedImage, for: .normal)
    }
    
    func toggle() {
        if isSelected() {
            setBackgroundImage(unselectedImage, for: .normal)
            setTitleColor(.black, for: .normal)
            if product == "other" {
                if let attributedText = attributedText {
                    setAttributedTitle(attributedText, for: .normal)
                }
            }
        } else {
            setBackgroundImage(selectedImage, for: .normal)
            setTitleColor(.white, for: .normal)
            if product == "other" {
                if let attributedText = attributedText {
                    let whiteText = NSAttributedString(string: attributedText.string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.cgColor, NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!])
                    setAttributedTitle(whiteText, for: .normal)
                }
            }
        }
        
    }
    
//    private func setupLayout() {
//        let constraints = [
//            selectButton.topAnchor.constraint(equalTo: topAnchor),
//            selectButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            selectButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            selectButton.trailingAnchor.constraint(equalTo: trailingAnchor)
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.height / 5
    }
    
}
