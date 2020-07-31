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
    var boxViews = [UIView(), UIView(), UIView()]
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
        stack.spacing = 20
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
        button.setTitle("    view completed challenges    ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 7, right: 0)
        button.layer.cornerRadius = 15
        button.layer.borderColor = #colorLiteral(red: 0.9764705882, green: 0.7411764706, blue: 0.7529411765, alpha: 1)
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        getAndParseData()
//        initBoxes()
        findAndSetDate()
        setBoxViews()
        
        addSubview(topLabel)
        addSubview(verticalStack)
        addSubview(viewCompletedChallengesButton)
        
        for i in 0...2 {
            verticalStack.addArrangedSubview(boxViews[i])
        }
        
        setupLayout()
        for i in 0...2 {
            boxViews[i].widthAnchor.constraint(equalTo: verticalStack.widthAnchor).isActive = true
            //boxViews[i].heightAnchor.constraint(equalTo: verticalStack.heightAnchor).isActive = true
        }
        
    }
    
    private func setupLayout() {
        let constraints = [
            topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            //topLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 13),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 7),
            verticalStack.bottomAnchor.constraint(equalTo: viewCompletedChallengesButton.topAnchor, constant: -19),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            viewCompletedChallengesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -13),
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
        print("Hi")
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
        
        progressBars[0].setBarColor(colorName: #colorLiteral(red: 0.9019607843, green: 0.5607843137, blue: 0.3764705882, alpha: 1))
        progressBars[1].setBarColor(colorName: #colorLiteral(red: 0.9607843137, green: 0.5764705882, blue: 0.5921568627, alpha: 1))
        progressBars[2].setBarColor(colorName: #colorLiteral(red: 0.4745098039, green: 0.7490196078, blue: 0.8784313725, alpha: 1))
        
        for i in 0...2 {
            boxViews[i].layer.cornerRadius = 20
            boxViews[i].backgroundColor = .white
            boxViews[i].clipsToBounds = true
            
            boxViews[i].dropShadow()
            
//            boxViews[i].layer.shadowColor = UIColor.black.cgColor
//            boxViews[i].layer.shadowOpacity = 1
//            boxViews[i].layer.shadowOffset = .zero
//            boxViews[i].layer.shadowRadius = 10
            //boxViews[i].backgroundColor = .red
            
            
            dateLabels[i].text = dateString
            dateLabels[i].textColor = #colorLiteral(red: 0.6117647059, green: 0.537254902, blue: 0.7490196078, alpha: 1)
            dateLabels[i].font = UIFont(name: "Amiko-Regular", size: 9)
            
            
            currLabels[i].text = "CURRENT CHALLENGE:"
            currLabels[i].textColor = .black
            currLabels[i].font = UIFont(name: "Amiko-Regular", size: 10)
            
            
            
            challengeLabels[i].text = challengeNameArray![i]
            challengeLabels[i].textColor = .black
            challengeLabels[i].font = UIFont(name: "Amiko-Regular", size: 12)
            
            
            levelLabels[i].text = "Level " + String(levelArray![i])
            levelLabels[i].textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)
            levelLabels[i].font = UIFont(name: "Amiko-Regular", size: 10)
            
            
            progressBars[i].setProgress(to: progressArray![i], withAnimation: true)
            
            boxViews[i].translatesAutoresizingMaskIntoConstraints = false
            dateLabels[i].translatesAutoresizingMaskIntoConstraints = false
            currLabels[i].translatesAutoresizingMaskIntoConstraints = false
            challengeLabels[i].translatesAutoresizingMaskIntoConstraints = false
            levelLabels[i].translatesAutoresizingMaskIntoConstraints = false
            progressBars[i].translatesAutoresizingMaskIntoConstraints = false
//
            boxViews[i].addSubview(dateLabels[i])
            boxViews[i].addSubview(currLabels[i])
            boxViews[i].addSubview(challengeLabels[i])
            boxViews[i].addSubview(levelLabels[i])
            boxViews[i].addSubview(progressBars[i])
            
            
            dateLabels[i].topAnchor.constraint(equalTo: boxViews[i].topAnchor, constant: 8).isActive = true
            dateLabels[i].trailingAnchor.constraint(equalTo: boxViews[i].trailingAnchor, constant: -22).isActive = true
            
            
            currLabels[i].topAnchor.constraint(equalTo: dateLabels[i].topAnchor, constant: 23).isActive = true
            currLabels[i].trailingAnchor.constraint(equalTo: dateLabels[i].centerXAnchor, constant: -11).isActive = true
            
            
            challengeLabels[i].leadingAnchor.constraint(equalTo: currLabels[i].leadingAnchor).isActive = true
            challengeLabels[i].topAnchor.constraint(equalTo: currLabels[i].bottomAnchor, constant: 6).isActive = true
            
            
            levelLabels[i].topAnchor.constraint(equalTo: challengeLabels[i].bottomAnchor, constant: 13.42).isActive = true
            levelLabels[i].leadingAnchor.constraint(equalTo: challengeLabels[i].leadingAnchor, constant: 9.92).isActive = true
            
            
            
            
            //progressBars[i].heightAnchor.constraint(equalTo: boxViews[i].heightAnchor).isActive = true
            progressBars[i].topAnchor.constraint(equalTo: boxViews[i].topAnchor, constant: 10).isActive = true
            progressBars[i].bottomAnchor.constraint(equalTo: boxViews[i].bottomAnchor, constant: -10).isActive = true
            
            progressBars[i].leadingAnchor.constraint(equalTo: boxViews[i].leadingAnchor, constant: 13).isActive = true
            progressBars[i].widthAnchor.constraint(equalTo: boxViews[i].widthAnchor, multiplier: 1/3).isActive = true
            
            
        }
    }
    
}
