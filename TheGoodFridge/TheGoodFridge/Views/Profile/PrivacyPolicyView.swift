//
//  PrivacyPolicyView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class PrivacyPolicyView: UIView {
    
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
    
    let viewInScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let headingHeight: CGFloat = 30
    let labelMultiplier: CGFloat = 0.9
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        
        backgroundColor = .clear
        setLabels()
        setHeadings()
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.alignment = .center
        
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
        stackView.addArrangedSubview(UIView())
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            introHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            introHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            introLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier),

            infoCollectionHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            infoCollectionHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            infoCollectionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier),

            shareInfoHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            shareInfoHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            shareInfoLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier),

            accessInfoHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            accessInfoHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            accessInfoLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier),

            privacyChildrenHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            privacyChildrenHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            privacyChildrenLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier),

            securityHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            securityHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            securityLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier),

            updatesHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            updatesHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),

            updatesLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: labelMultiplier)
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
        //view.addBorders(edges: [.bottom], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
        
        let label = UILabel()
        
        changeLabel(label: label, text: text, font: UIFont(name: "Amiko-Bold", size: 14)!, color: UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1))
        view.addSubview(label)
        
        let constraints = [
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: labelMultiplier),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
