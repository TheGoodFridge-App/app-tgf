//
//  ProfilePageView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase

//let pvc = ProfileViewController()

class ProfilePageView: UIView {

    var settingsButton = UIButton()
    let nameLabel = UILabel()

    let settingsSymbol: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
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
    
    //Segmented Tabs
    let tabsSegmented: CustomSegmentedControl
    
    var user = User()
    
    override init(frame: CGRect) {
        tabsSegmented = CustomSegmentedControl(buttonTitle: ["Challenges","Stats"]) //"Archive"
        tabsSegmented.user = user
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        user.delegate = self
        //get name of user
        nameLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        nameLabel.textColor = UIColor.black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        if let userData = user.getUserData() {
            nameLabel.text = "\(userData.first_name) \(userData.last_name)"
        }
        
        backgroundColor = .clear
        
        addSubview(nameLabel)
        addSubview(settingsSymbol)
        addSubview(profilePicture)
        addSubview(tabsSegmented)
        
        setupLayoutPsv()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutPsv() {
        let topMargin: CGFloat = 60
        let spacing: CGFloat = 20
        let settingsSize: CGFloat = 25
        let profileSize: CGFloat = 100
        
        let constraints = [
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            
            settingsSymbol.topAnchor.constraint(equalTo: topAnchor, constant: topMargin),
            settingsSymbol.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),
            settingsSymbol.widthAnchor.constraint(equalToConstant: settingsSize),
            settingsSymbol.heightAnchor.constraint(equalToConstant: settingsSize),
            
            profilePicture.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: spacing),
            profilePicture.centerXAnchor.constraint(equalTo: centerXAnchor),
            profilePicture.widthAnchor.constraint(equalToConstant: profileSize),
            profilePicture.heightAnchor.constraint(equalToConstant: profileSize),

            tabsSegmented.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: spacing),
            tabsSegmented.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabsSegmented.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabsSegmented.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height / 2
        profilePicture.clipsToBounds = true
    }

}

extension ProfilePageView: UserDelegate {
    
    func didGetUserData(userData: UserData) {
        DispatchQueue.main.async {
            self.nameLabel.text = "\(userData.first_name) \(userData.last_name)"
        }
    }
    
}
