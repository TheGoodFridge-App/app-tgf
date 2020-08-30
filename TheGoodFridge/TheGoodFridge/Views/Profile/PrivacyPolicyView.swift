//
//  PrivacyPolicyView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class PrivacyPolicyView: UIView {
    
    let privacyLabel = UILabel()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let introHeading = UIView()
    let infoCollectionHeading = UIView()
    let shareInfoHeading = UIView()
    let accessInfoHeading = UIView()
    let privacyChildrenHeading = UIView()
    let securityHeading = UIView()
    let updatesHeading = UIView()
    
    let introLabel = UILabel()
    let infoCollectionLabel = UILabel()
    let shareInfoLabel = UILabel()
    let accessInfoLabel = UILabel()
    let privacyChildrenLabel = UILabel()
    let securityLabel = UILabel()
    let updatesLabel = UILabel()

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
    
    let viewInScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        
        backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setLabels()
        setHeadings()
        
        addSubview(wrapperView)
        wrapperView.addSubview(backButton)
        wrapperView.addSubview(privacyLabel)
        wrapperView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(introHeading)
        stackView.addArrangedSubview(introLabel)
        stackView.addArrangedSubview(infoCollectionHeading)
        stackView.addArrangedSubview(infoCollectionLabel)
        stackView.addArrangedSubview(shareInfoHeading)
        stackView.addArrangedSubview(shareInfoLabel)
        stackView.addArrangedSubview(accessInfoHeading)
        stackView.addArrangedSubview(accessInfoLabel)
        stackView.addArrangedSubview(privacyChildrenHeading)
        stackView.addArrangedSubview(privacyChildrenLabel)
        stackView.addArrangedSubview(securityHeading)
        stackView.addArrangedSubview(securityLabel)
        stackView.addArrangedSubview(updatesHeading)
        stackView.addArrangedSubview(updatesLabel)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            wrapperView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 31.5),
            
            privacyLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            privacyLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -5),
            privacyLabel.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: 27),
            
            scrollView.topAnchor.constraint(equalTo: privacyLabel.bottomAnchor, constant: 21),
            scrollView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            introHeading.heightAnchor.constraint(equalToConstant: 33),
            introHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            introLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            introLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            infoCollectionHeading.heightAnchor.constraint(equalToConstant: 33),
            infoCollectionHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            infoCollectionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            infoCollectionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            shareInfoHeading.heightAnchor.constraint(equalToConstant: 33),
            shareInfoHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            shareInfoLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            shareInfoLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            accessInfoHeading.heightAnchor.constraint(equalToConstant: 33),
            accessInfoHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            accessInfoLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            accessInfoLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            privacyChildrenHeading.heightAnchor.constraint(equalToConstant: 33),
            privacyChildrenHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            privacyChildrenLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            privacyChildrenLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            securityHeading.heightAnchor.constraint(equalToConstant: 33),
            securityHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            securityLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            securityLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            updatesHeading.heightAnchor.constraint(equalToConstant: 33),
            updatesHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            updatesLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            updatesLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabel(label: UILabel, text: String, font: UIFont, color: UIColor) {
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = text
        label.font = font
        label.textColor = color
    }
    
    func setLabels() {
        changeLabel(label: privacyLabel, text: "Privacy Policy", font: UIFont(name: "Amiko-Regular", size: 24)!, color: .black)
        
        changeLabel(label: introLabel, text: "When you download the Good Fridge App, you trust us with your personal data. We strive to maintain that trust by helping you understand and keeping you informed of how we process and protect your personal data in compliance with applicable laws. \n\nThis privacy policy (“Privacy Policy”) describes how information and data is collected from you when you use the App, and how we use, share and manage your information and data. By using the App, you consent to the collection, use, processing, and sharing of your information as described in this Privacy Policy.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
        
        changeLabel(label: infoCollectionLabel, text: "The following data is collected by the App:\n\nData you provide to us. This includes:\n\n- User profile: We collect data when you create or update your account on the App. This may include your name, email, password, profile picture, and your interests and preferences related to the App's features.\n\n- User content: We collect data you provide when you contact customer support with questions about the App. Data created during use of the App. This includes:\n\n- Grocery-related data: We may collect data relating to your grocery-related activities such as grocery list entries and grocery product selections.\n\nWe don't collect any data relating to your app usage, or device data such as device IP address, serial number, or settings.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
        
        changeLabel(label: shareInfoLabel, text: "We are not working with third parties currently, and will not be disclosing your information to any third party affiliates.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
        
        changeLabel(label: accessInfoLabel, text: "You may request access to, correct, or delete your personal data at any time. Please feel free to send an e-mail to wendyli328@g.ucla.edu, and we will get back to you as soon as possible.\n\nPlease include your registration information in the email. We may ask you to provide additional information for identity verification purposes, or to verify that you are in possession of an applicable email account.\n\nWe will retain your information until you delete your account or email us to request for deletion. Please note that some or all of the information you provided may be required in order for the App to function properly.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
        
        changeLabel(label: privacyChildrenLabel, text: "The App is not intended for children under age 13. We do not knowingly collect or distribute personal information from or about children under the age of 13. If you are a parent or guardian and is aware that your child has provided us with information without your consent, please contact us at wendyli328@g.ucla.edu.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
        
        changeLabel(label: securityLabel, text: "The App has implemented reasonable physical, electronic, and procedural safeguards to protect personal information we procure and maintain through the App. However, although we aim to provide reasonable security for data we procure and maintain, no security system can prevent all potential security breaches. As a result, we cannot guarantee or warrant the security of any information you transmit on or through the Services and you do so at your own risk.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
        
        changeLabel(label: updatesLabel, text: "We will notify you of material changes to this Privacy Policy by at least thirty (30) days before the effective date of the changes. If you do not agree to such changes following such notice, you can choose to discontinue your use of the App prior to the time the modified privacy policy takes effect. If you continue using the App after the modified privacy policy takes effect, you will be bound by the modified privacy policy.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black)
    }
    
    func changeHeading(view: UIView, text: String) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1)
        view.addBorders(edges: [.bottom], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
        
        let label = UILabel()
        
        changeLabel(label: label, text: ("    " + text), font: UIFont(name: "Amiko-Bold", size: 14)!, color: UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1))
        view.addSubview(label)
        
        
        let constraints = [
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setHeadings() {
        changeHeading(view: introHeading, text: "Introduction")
        changeHeading(view: infoCollectionHeading, text: "Information We Collect From You")
        changeHeading(view: shareInfoHeading, text: "How We Share Your Information")
        changeHeading(view: accessInfoHeading, text: "Your Access And Control of Your Information")
        changeHeading(view: privacyChildrenHeading, text: "Privacy of Children")
        changeHeading(view: securityHeading, text: "Security Measures")
        changeHeading(view: updatesHeading, text: "Updates to this Privacy Policy")
    }
 
    func setupScrollView() {
        //Add and setup scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false;

        //Add and setup stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 22;

    }
    
}
