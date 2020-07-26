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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ppage.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        changeName()
        ppage.nameStack.addArrangedSubview(nameLabel)
        view.addSubview(ppage)
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            ppage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            ppage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            ppage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ppage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
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
