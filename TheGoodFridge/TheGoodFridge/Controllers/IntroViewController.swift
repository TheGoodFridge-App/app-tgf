//
//  SetupViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/3/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    let firstName = User.shared.getFirstName() ?? ""
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        var bigText = NSMutableAttributedString(
            string: "Hello \(firstName),\nText Text Text Text Text Text Text Text\n\n",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 24)!]
        )
        let smallText = NSAttributedString(
            string: "text text text text text text text text text text text text text text text text text text text text",
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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 18)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(startButton)
        view.addSubview(introTextView)
        
        setupLayout()
    }

    private func setupLayout() {
        let textMargin: CGFloat = 80
        let buttonMargin: CGFloat = 70
        let buttonHeight: CGFloat = 70
        let spacing: CGFloat = 25
        
        let constraints = [
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
        setupVC.modalPresentationStyle = .fullScreen
        self.present(setupVC, animated: true, completion: nil)
    }
    
}
