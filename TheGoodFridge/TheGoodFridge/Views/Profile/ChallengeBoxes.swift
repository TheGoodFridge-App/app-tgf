//
//  ChallengeBoxes.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 20
        clipsToBounds = true
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


class ChallengeBoxes: UIView {
    
    var progressArray: [Float]?
    var levelArray: [Int]?
    var challengeNameArray: [String]?
    var boxViews = [ChallengeBox(), ChallengeBox(), ChallengeBox()]
    var dateString = ""
    var dateLabels = [UILabel(), UILabel(), UILabel()]
    var currLabels = [UILabel(), UILabel(), UILabel()]
    var challengeLabels = [UILabel(), UILabel(), UILabel()]
    var levelLabels = [UILabel(), UILabel(), UILabel()]
    var progressBars = [CircularProgressBar(), CircularProgressBar(), CircularProgressBar()]
    
    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    } ()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "CURRENT CHALLENGES"
        label.textColor = .black
        label.font = UIFont(name: "Amiko-Regular", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let viewCompletedChallengesButton: UIButton = {
        let button = UIButton()
        button.setTitle("view completed challenges", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 10, bottom: 7, right: 10)
        button.layer.cornerRadius = 15
        button.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.7411764706, blue: 0.7529411765, alpha: 1)
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        getAndParseData()
        findAndSetDate()
        setBoxViews()
        
        backgroundColor = .clear
        
        addSubview(topLabel)
        addSubview(verticalStack)
        addSubview(viewCompletedChallengesButton)
        
        for i in 0...2 {
            verticalStack.addArrangedSubview(boxViews[i])
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        let topMargin: CGFloat = 15
        
        for i in 0...2 {
            boxViews[i].widthAnchor.constraint(equalTo: verticalStack.widthAnchor).isActive = true
            //boxViews[i].heightAnchor.constraint(equalTo: verticalStack.heightAnchor).isActive = true
        }
        
        let constraints = [
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: topMargin * 2),
            //topLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 13),
            //topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: topMargin),
            verticalStack.bottomAnchor.constraint(equalTo: viewCompletedChallengesButton.topAnchor, constant: -topMargin),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            viewCompletedChallengesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -topMargin),
            viewCompletedChallengesButton.centerXAnchor.constraint(equalTo: centerXAnchor)
//            viewCompletedChallengesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
//            viewCompletedChallengesButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAndParseData() {
        //sets the necessary variables. Set progressArray, levelArray, challengeNameArray
        
        progressArray = [0.3, 0.6, 0.9]
        levelArray = [1, 2, 3]
        challengeNameArray = ["Preserving Biodiversity", "Preserving Biodiversity", "Preserving Biodiversity"]
    }
    
    func findAndSetDate() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let nameOfMonth = dateFormatter.string(from: now)
        dateFormatter.dateFormat = "YYYY"
        let year = dateFormatter.string(from: now)
        dateString = nameOfMonth + " " + year
    }
    
    func setBoxViews() {
        
        boxViews[0].circularProgressBar.setBarColor(colorName: #colorLiteral(red: 0.9019607843, green: 0.5607843137, blue: 0.3764705882, alpha: 1))
        boxViews[1].circularProgressBar.setBarColor(colorName: #colorLiteral(red: 0.9607843137, green: 0.5764705882, blue: 0.5921568627, alpha: 1))
        boxViews[2].circularProgressBar.setBarColor(colorName: #colorLiteral(red: 0.4745098039, green: 0.7490196078, blue: 0.8784313725, alpha: 1))
        
        for i in 0..<boxViews.count {
            boxViews[i].challengeNameLabel.text = challengeNameArray![i]
            boxViews[i].levelLabel.text = "Level " + String(levelArray![i])
            boxViews[i].circularProgressBar.setProgress(to: progressArray![i], withAnimation: true)
        }
    }
    
}
