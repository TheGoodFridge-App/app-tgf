//
//  AccountDetailsView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
import Firebase
import  FirebaseAuth

class AccountDetailsView: UIView {
    
    let accDetailsLabel = UILabel()
    let firstNameLabel = UILabel()
    let lastNameLabel = UILabel()
    let emailLabel = UILabel()
    let passwordLabel = UILabel()
    
    let firstNameView = UIView()
    let lastNameView = UIView()
    let emailView = UIView()
    let passwordView = UIView()
    
    class CircularImageView: UIImageView {
        override func layoutSubviews() {
            super.layoutSubviews()
            //self.frame.size.height /= 1.25
            self.layer.cornerRadius = self.frame.size.height/2
            self.frame.size.width = self.frame.size.height
            self.contentMode = .scaleAspectFit
            self.clipsToBounds = true
        }
    }
    //profile picture
    let profilePicture: UIImageView = {
        let img = CircularImageView()
        img.translatesAutoresizingMaskIntoConstraints = false//IssueButtonHighlighted
        return img
    } ()
    
    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "BackButton"), for: .normal)
        return button
    } ()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "EditPage"), for: .normal)
        return button
    } ()
    
    let inputFieldsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 23
        return stack
    } ()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont(name: "Amiko-SemiBold", size: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 1)
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 20
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setLabels()
        setOldProfileImage()
        setViews()
        
        addSubview(wrapperView)
        wrapperView.addSubview(backButton)
        wrapperView.addSubview(accDetailsLabel)
        wrapperView.addSubview(profilePicture)
        wrapperView.addSubview(editButton)
        wrapperView.addSubview(inputFieldsStackView)
        wrapperView.addSubview(saveButton)
        
        inputFieldsStackView.addArrangedSubview(firstNameView)
        inputFieldsStackView.addArrangedSubview(lastNameView)
        inputFieldsStackView.addArrangedSubview(emailView)
        inputFieldsStackView.addArrangedSubview(passwordView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            wrapperView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 57),
            backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 69),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 31.5),
            
            accDetailsLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            accDetailsLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 17),
            accDetailsLabel.bottomAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 44),
            
            profilePicture.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: -25),
            profilePicture.topAnchor.constraint(equalTo: accDetailsLabel.bottomAnchor, constant: 23),
            profilePicture.bottomAnchor.constraint(equalTo: accDetailsLabel.bottomAnchor, constant: 103),
            
            editButton.leadingAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: -8.5),
            editButton.trailingAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: 8.5),
            editButton.topAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 15),
            editButton.bottomAnchor.constraint(equalTo: profilePicture.bottomAnchor, constant: 32),
            
            inputFieldsStackView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 23),
            inputFieldsStackView.bottomAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 300),
            inputFieldsStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 35),
            inputFieldsStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -35),
            
            firstNameView.leadingAnchor.constraint(equalTo: inputFieldsStackView.leadingAnchor),
            firstNameView.trailingAnchor.constraint(equalTo: inputFieldsStackView.trailingAnchor),
            
            lastNameView.leadingAnchor.constraint(equalTo: inputFieldsStackView.leadingAnchor),
            lastNameView.trailingAnchor.constraint(equalTo: inputFieldsStackView.trailingAnchor),
            
            emailView.leadingAnchor.constraint(equalTo: inputFieldsStackView.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: inputFieldsStackView.trailingAnchor),
            
            passwordView.leadingAnchor.constraint(equalTo: inputFieldsStackView.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: inputFieldsStackView.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: inputFieldsStackView.bottomAnchor, constant: 45),
            saveButton.bottomAnchor.constraint(equalTo: inputFieldsStackView.bottomAnchor, constant: 90),
            saveButton.leadingAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: -61.5),
            saveButton.trailingAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: 61.5)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabel(label: UILabel, text: String, font: UIFont, color: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = text
        label.font = font
        label.textColor = color
    }
    
    func setLabels() {
        changeLabel(label: accDetailsLabel, text: "Account Details", font: UIFont(name: "Amiko-SemiBold", size: 20)!, color: .black)
        changeLabel(label: firstNameLabel, text: "First Name", font: UIFont(name: "Amiko-SemiBold", size: 15)!, color: #colorLiteral(red: 0.5176470588, green: 0.7490196078, blue: 0.4117647059, alpha: 1))
        changeLabel(label: lastNameLabel, text: "Last Name", font: UIFont(name: "Amiko-SemiBold", size: 15)!, color: #colorLiteral(red: 0.5176470588, green: 0.7490196078, blue: 0.4117647059, alpha: 1))
        changeLabel(label: emailLabel, text: "Email", font: UIFont(name: "Amiko-SemiBold", size: 15)!, color: #colorLiteral(red: 0.5176470588, green: 0.7490196078, blue: 0.4117647059, alpha: 1))
        changeLabel(label: passwordLabel, text: "Password", font: UIFont(name: "Amiko-SemiBold", size: 15)!, color: #colorLiteral(red: 0.5176470588, green: 0.7490196078, blue: 0.4117647059, alpha: 1))
    }
    
    func getImageName() -> String {
        let imgName = "DefaultProfilePicture"
        return imgName
    }
    
    func setOldProfileImage() {
        profilePicture.image = UIImage(named: getImageName())
    }
    
    func changeViews(view: UIView, label: UILabel, _ grayText: Int) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBorders(edges: [.bottom], color: UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 0.3))
        
        let textField = UITextField()
        textField.placeholder = label.text
        textField.font = UIFont(name: "Amiko-Regular", size: 12)
        if grayText == 1 {
            textField.textColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        }
        else {
            textField.textColor = .black
        }
        textField.clearButtonMode = .whileEditing
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .default
        textField.keyboardAppearance = .light
        textField.returnKeyType = .default
        
        
        view.addSubview(label)
        
        let constraints = [
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setViews() {
        changeViews(view: firstNameView, label: firstNameLabel, 0)
        changeViews(view: lastNameView, label: lastNameLabel, 0)
        changeViews(view: emailView, label: emailLabel, 1)
        changeViews(view: passwordView, label: passwordLabel, 0)
    }
    
}
