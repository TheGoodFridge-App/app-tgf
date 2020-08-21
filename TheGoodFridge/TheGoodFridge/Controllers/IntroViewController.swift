//
//  SetupViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/3/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class IntroViewController: UIViewController {

    var user = User()
    
    let introBackground: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IntroBackgroundImage"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        var bigText = NSMutableAttributedString(
            string: "Hello \(user.firstName ?? ""),\nWelcome to The Good Fridge.\n\n",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 24)!]
        )
        let smallText = NSAttributedString(
            string: "Before we start, we would like to ask you some questions to personalize your experience.",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 15)!]
        )
        bigText.append(smallText)
        textView.attributedText = bigText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("I'm Ready!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 18)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.setBackgroundImage(UIImage(named: "GreenButtonImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        
        view.addSubview(startButton)
        view.addSubview(introTextView)
        view.addSubview(introBackground)
        
        view.sendSubviewToBack(introBackground)
        
        setupLayout()
    }

    private func setupLayout() {
        let textMargin: CGFloat = 80
        let buttonMargin: CGFloat = 70
        let buttonHeight: CGFloat = 75
        let spacing: CGFloat = 25
        
        let constraints = [
            introBackground.topAnchor.constraint(equalTo: view.topAnchor),
            introBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            introBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            introBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonMargin),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonMargin),
            startButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            introTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: textMargin),
            introTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -textMargin),
            introTextView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -spacing)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLayoutSubviews() {
        startButton.layer.cornerRadius = startButton.frame.size.height / 5
    }
    
    @objc func tappedStartButton() {
        let setupVC = SetupViewController()
        setupVC.setupData.lastName = user.lastName
        setupVC.setupData.firstName = user.firstName
        setupVC.setupData.email = user.email
        setupVC.user = user
        setupVC.modalPresentationStyle = .fullScreen
        self.present(setupVC, animated: true, completion: nil)
    }
    
}
