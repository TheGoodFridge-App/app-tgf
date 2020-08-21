//
//  ProfileViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    var profilePageView = ProfilePageView()
    var user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAndViews()

        view.addSubview(profilePageView)
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            profilePageView.topAnchor.constraint(equalTo: view.topAnchor),
            profilePageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profilePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profilePageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    func setButtonsAndViews() {
        profilePageView.translatesAutoresizingMaskIntoConstraints = false
        profilePageView.settingsSymbol.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
    }
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
    }

}
