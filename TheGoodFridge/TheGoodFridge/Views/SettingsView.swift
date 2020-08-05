//
//  SettingsView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/4/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    let myAccountLabel = UILabel()
    let blankLabel = UILabel()
    let appSupportLabel = UILabel()
    
    let fullScreenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        return view
    } ()
    
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
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
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backingImageView.image = backingImage
        
        blankLabel.translatesAutoresizingMaskIntoConstraints = false
        setLabels()
        
        addSubview(fullScreenView)
        fullScreenView.addSubview(wrapperView)
        //wrapperView.addSubview(settingsStack)
        wrapperView.addSubview(backButton)
        wrapperView.addSubview(settingsLabel)
        wrapperView.addSubview(settingsSymbol)
        wrapperView.addSubview(stackView)
        
        stackView.addArrangedSubview(myAccountLabel)
        stackView.addArrangedSubview(blankLabel)
        stackView.addArrangedSubview(appSupportLabel)
        
        
//        settingsStack.addArrangedSubview(backButton)
//        settingsStack.addArrangedSubview(settingsLabel)
//        settingsStack.addArrangedSubview(settingsSymbol)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let constraints = [
//            backingImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            backingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            fullScreenView.topAnchor.constraint(equalTo: topAnchor),
            fullScreenView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullScreenView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fullScreenView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            wrapperView.topAnchor.constraint(equalTo: fullScreenView.safeAreaLayoutGuide.topAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: fullScreenView.leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: fullScreenView.trailingAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: fullScreenView.bottomAnchor),

            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 62),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 19),
            backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 74),
            backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 26.5),
            
            settingsLabel.centerXAnchor.constraint(equalTo: fullScreenView.centerXAnchor),
            settingsLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 51),
            settingsLabel.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 83),
            
            settingsSymbol.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 55),
            settingsSymbol.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 80),
            settingsSymbol.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -34),
            settingsSymbol.leadingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -60),
            
            stackView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 70),
            stackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: wrapperView.safeAreaLayoutGuide.bottomAnchor, constant: -23),
            
//            myAccountLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            myAccountLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/3),
//
//            blankLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            blankLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/3),
//
//            appSupportLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
//            appSupportLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1/3)
            
            
//            settingsStack.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 40),
//            settingsStack.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 70),
//            settingsStack.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 45),
//            settingsStack.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -30),

//            backButton.topAnchor.constraint(equalTo: settingsStack.topAnchor, constant: 8),
//            backButton.bottomAnchor.constraint(equalTo: settingsStack.bottomAnchor, constant: -8),
//            backButton.widthAnchor.constraint(equalTo: settingsStack.widthAnchor, multiplier: 0.5/12),
            
//            settingsLabel.heightAnchor.constraint(equalTo: settingsStack.heightAnchor),
//            settingsLabel.widthAnchor.constraint(equalTo: settingsStack.widthAnchor, multiplier: 10.5/12),
//
////            settingsSymbol.heightAnchor.constraint(equalTo: settingsStack.heightAnchor),
//            settingsSymbol.topAnchor.constraint(equalTo: settingsStack.topAnchor, constant: 5),
//            settingsSymbol.bottomAnchor.constraint(equalTo: settingsStack.bottomAnchor, constant: 0),
//            settingsSymbol.widthAnchor.constraint(equalTo: settingsStack.widthAnchor, multiplier: 1/12)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
    }
    
    @objc func tappedSettingsButton() {
        
    }
    
    
    
    func changeLabel(label: UILabel, text: String, font: UIFont, color: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = text
        label.font = font
        label.textColor = color
    }
    
    func setLabels() {
        changeLabel(label: myAccountLabel, text: "     MY ACCOUNT", font: UIFont(name: "Amiko-Bold", size: 14)!, color: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1))
        changeLabel(label: appSupportLabel, text: "    APP SUPPORT", font: UIFont(name: "Amiko-Bold", size: 14)!, color: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1))
    }
    
    
}
