//
//  PrivacyPolicyViewController.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/8/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class PrivacyPolicyViewController: UIViewController {
    
    let privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.font = UIFont(name: "Amiko-Regular", size: 24)!
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        button.setImage(UIImage(named: "SettingsBackImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let privacyPage = PrivacyPolicyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.titleView = privacyLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.hidesBackButton = true
        backButton.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        privacyPage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(privacyPage)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [

            privacyPage.topAnchor.constraint(equalTo: view.topAnchor),
            privacyPage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            privacyPage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            privacyPage.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
