//
//  SettingsViewController.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    
    let settingsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    let settingsSymbol: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
        button.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
        return button
    } ()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    } ()
    
    let settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Amiko-Regular", size: 24)
        return label
    } ()
    
    
//    let backingImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
//    var backingImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
//        backingImageView.image = backingImage
        
        view.addSubview(wrapperView)
        wrapperView.addSubview(settingsStack)
        settingsStack.addArrangedSubview(backButton)
        settingsStack.addArrangedSubview(settingsLabel)
        settingsStack.addArrangedSubview(settingsSymbol)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
//            backingImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            backingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            settingsStack.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            settingsStack.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 50),
            settingsStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 45),
            settingsStack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -30),

            backButton.topAnchor.constraint(equalTo: settingsStack.topAnchor, constant: 8),
            backButton.bottomAnchor.constraint(equalTo: settingsStack.bottomAnchor, constant: -8),
            backButton.widthAnchor.constraint(equalTo: settingsStack.widthAnchor, multiplier: 0.5/12),
            
            settingsLabel.heightAnchor.constraint(equalTo: settingsStack.heightAnchor),
            settingsLabel.widthAnchor.constraint(equalTo: settingsStack.widthAnchor, multiplier: 10.5/12),
            
//            settingsSymbol.heightAnchor.constraint(equalTo: settingsStack.heightAnchor),
            settingsSymbol.topAnchor.constraint(equalTo: settingsStack.topAnchor, constant: 5),
            settingsSymbol.bottomAnchor.constraint(equalTo: settingsStack.bottomAnchor, constant: 0),
            settingsSymbol.widthAnchor.constraint(equalTo: settingsStack.widthAnchor, multiplier: 1/12)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedSettingsButton() {
        let settingsVC = SettingsViewController()
        settingsVC.modalPresentationStyle = .fullScreen
        self.present(settingsVC, animated: true, completion: nil)
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//            settingsVC.backingImage = self.tabBarController?.view.asImage()
//            self.present(settingsVC, animated: false, completion: nil)
//        })
    }
    
    @objc func tappedBackButton() {
        let tab = TabBarController()
//        tab.changeSelectedVC(index: 2)
        tab.modalPresentationStyle = .fullScreen
        self.present(tab, animated: true, completion: nil)
        
//        let profileVC = ProfileViewController()
//        profileVC.modalPresentationStyle = .fullScreen
//        self.present(profileVC, animated: true, completion: nil)
    }
}
