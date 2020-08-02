//
//  ProfileViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

var ppage = ProfilePageView()
var challenges = UIButton()
var progress = UIButton()
var stats = UIButton()
var backButton = UIButton()
var settingsButton = UIButton()
let nameLabel = UILabel()


class ProfileViewController: UIViewController {

    let settingsSymbol: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
        return button
    } ()
    
    let blankLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
    let blankLabelEnd: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
//    let backgroundImage: UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "ProfileBackgroundImage")
//
//        return img
//    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ppage.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        changeName()
//        view.addSubview(backgroundImage)
        ppage.nameStack.addArrangedSubview(blankLabel)
        ppage.nameStack.addArrangedSubview(nameLabel)
        ppage.nameStack.addArrangedSubview(settingsSymbol)
        ppage.nameStack.addArrangedSubview(blankLabelEnd)
        ppage.nameStack.alignment = .center
        nameLabel.textAlignment = .center
        view.addSubview(ppage)
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            ppage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            ppage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ppage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ppage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            blankLabel.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 2/15),
            blankLabel.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 0),
            blankLabel.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: 0),
            
            nameLabel.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 11/15),
            nameLabel.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: 0),
            
            //settingsSymbol.trailingAnchor.constraint(equalTo: ppage.nameStack.trailingAnchor, constant: 0),
            settingsSymbol.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 20),
            settingsSymbol.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: -20),
            settingsSymbol.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 1/15),
            
            blankLabelEnd.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 1/15),
            blankLabelEnd.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 0),
            blankLabelEnd.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: 0)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func createButtons(_ name: String) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 15)
        button.setTitle(name, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }
    
    func declareAllButtons() {
        challenges = createButtons("Challenges")
        progress = createButtons("Progress")
        stats = createButtons("Stats")
        challenges.contentEdgeInsets.left = 5
        progress.contentEdgeInsets.left = 10
        stats.contentEdgeInsets.left = -15
    }
    
    func changeName() {
        //get name of user
        nameLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        nameLabel.textColor = UIColor.black
        nameLabel.text = "Maddie Boesen"
    }

}
