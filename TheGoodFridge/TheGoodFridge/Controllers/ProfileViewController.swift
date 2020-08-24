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
    
    let profilePageView = ProfilePageView()
    var user = User()
    
    let profileChallengesBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileChallengesBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsAndViews()
        
        profilePageView.user = user
        
        view.addSubview(profilePageView)
        view.addSubview(profileChallengesBackground)
        view.sendSubviewToBack(profileChallengesBackground)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            profilePageView.topAnchor.constraint(equalTo: view.topAnchor),
            profilePageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profilePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profilePageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            profileChallengesBackground.topAnchor.constraint(equalTo: view.topAnchor),
            profileChallengesBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileChallengesBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileChallengesBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
