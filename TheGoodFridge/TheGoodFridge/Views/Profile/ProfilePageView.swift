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
    let tabsSegmented = CustomSegmentedControl(buttonTitle: ["Challenges","Stats"]) //"Archive"
    
    let user = User()
    
    override init(frame: CGRect) {
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
        
        backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        
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
    
//    @objc func tappedSettingsButton() {
////        profileStackView.removeFromSuperview()
////        wrapperView.isHidden = true
////        wrapperView.removeFromSuperview()
//
//        //pvc?.ppage.removeFromSuperview()
//
//        pvc?.switchToSettingsPage()
//
////        pvc?.ppage.isHidden = true
//
//
//        //pvc?.ppage = SettingsView()
//
//
//        pvc?.wrapperView.addSubview(pvc!.settingsPage)
//        setSettingsView()
//    }
    

//    func setView(view: UIView) {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        pvc!.wrapperView.addSubview(view)
//        view.topAnchor.constraint(equalTo: pvc!.wrapperView.topAnchor, constant: 0).isActive = true
//        view.bottomAnchor.constraint(equalTo: pvc!.wrapperView.bottomAnchor, constant: 0).isActive = true
//        view.leadingAnchor.constraint(equalTo: pvc!.wrapperView.leadingAnchor, constant: 0).isActive = true
//        view.trailingAnchor.constraint(equalTo: pvc!.wrapperView.trailingAnchor, constant: 0).isActive = true
//    }
//
//    func setSettingsView() {
//        pvc!.settingsPage.topAnchor.constraint(equalTo: pvc!.wrapperView.topAnchor, constant: 0).isActive = true
//        pvc!.settingsPage.bottomAnchor.constraint(equalTo: pvc!.wrapperView.bottomAnchor, constant: 0).isActive = true
//        pvc!.settingsPage.leadingAnchor.constraint(equalTo: pvc!.wrapperView.leadingAnchor, constant: 0).isActive = true
//        pvc!.settingsPage.trailingAnchor.constraint(equalTo: pvc!.wrapperView.trailingAnchor, constant: 0).isActive = true
//    }

}

extension ProfilePageView: UserDelegate {
    
    func didGetUserData(userData: UserData) {
        DispatchQueue.main.async {
            self.nameLabel.text = "\(userData.first_name) \(userData.last_name)"
        }
    }
    
}
