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

protocol ProfileDelegate {
    func didGetProfilePicture(image: UIImage?)
}

class ProfileViewController: UIViewController {
    
    var settingsButton = UIButton()
    let nameLabel = UILabel()

    let settingsSymbol: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    func changeName() {
        //get name of user
        nameLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        nameLabel.textColor = UIColor.black
    }

    //profile picture
    let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DefaultProfilePicture")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SettingsBackImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Segmented Tabs
    var tabsSegmented: CustomSegmentedControl = CustomSegmentedControl(buttonTitle: ["Challenges","Stats"]) //"Archive"
    
    var user = User()
    
    let profileChallengesBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileChallengesBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Check for profile picture
        user.profileDelegate = self
        user.getProfilePicture()
        
        tabsSegmented.user = user
        
        user.userDelegate = self
        //get name of user
        nameLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        nameLabel.textColor = UIColor.black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        if let userData = user.getUserData() {
            nameLabel.text = "\(userData.first_name) \(userData.last_name)"
        }
        
        settingsSymbol.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
        
        view.backgroundColor = .clear
        
        view.addSubview(nameLabel)
        view.addSubview(settingsSymbol)
        view.addSubview(profilePicture)
        view.addSubview(tabsSegmented)
        view.addSubview(profileChallengesBackground)
        view.sendSubviewToBack(profileChallengesBackground)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        let topMargin: CGFloat = 60
        let spacing: CGFloat = 20
        let settingsSize: CGFloat = 20
        let profileSize: CGFloat = 100
        
        let constraints = [
            profileChallengesBackground.topAnchor.constraint(equalTo: view.topAnchor),
            profileChallengesBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileChallengesBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileChallengesBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topMargin),
            
            settingsSymbol.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            settingsSymbol.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            settingsSymbol.widthAnchor.constraint(equalToConstant: settingsSize),
            settingsSymbol.heightAnchor.constraint(equalToConstant: settingsSize),
            
            profilePicture.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: spacing),
            profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePicture.widthAnchor.constraint(equalToConstant: profileSize),
            profilePicture.heightAnchor.constraint(equalToConstant: profileSize),

            tabsSegmented.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: spacing),
            tabsSegmented.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabsSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabsSegmented.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.profileDelegate = self
        settingsVC.user = user
        settingsVC.profilePicture.image = profilePicture.image
        let navigationVC = UINavigationController(rootViewController: settingsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        navigationVC.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsSymbol)
        navigationVC.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButtonImageView)
        self.present(navigationVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height / 2
        profilePicture.clipsToBounds = true
    }
}

extension ProfileViewController: UserDelegate {
    
    func didGetUserData(userData: UserData) {
        DispatchQueue.main.async {
            self.nameLabel.text = "\(userData.first_name) \(userData.last_name)"
        }
    }
    
}

extension ProfileViewController: ProfileDelegate {
    
    func didGetProfilePicture(image: UIImage?) {
        DispatchQueue.main.async {
            self.profilePicture.image = image
        }
    }
    
}
