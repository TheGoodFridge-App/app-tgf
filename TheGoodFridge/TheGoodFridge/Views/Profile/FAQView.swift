//
//  FAQView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class FAQView: UIView {
    
    let welcomeLabel = UILabel()
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    let challengesHeading = UIView()
    let impactHeading = UIView()
    let recommendHeading = UIView()
    let reputableHeading = UIView()
    
    let challengesLabel = UILabel()
    let impactLabel = UILabel()
    let recommendLabel = UILabel()
    let reputableLabel = UILabel()

    let viewInScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    let backgroundView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "FAQBackground")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    } ()
    
    let furtherQuestionsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        return view
    } ()
    
    let furtherQuestionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        label.text = "Further Questions? Contact us at\nhelp@goodfridge.com"
        label.font = UIFont(name: "Amiko-SemiBold", size: 16)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    } ()
    
    let wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.941, green: 0.969, blue: 0.929, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let spacing: CGFloat = 20
    let headingHeight: CGFloat = 30
    let labelMultiplier: CGFloat = 0.9
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        setLabels()
        setHeadings()
        
        addSubview(backgroundView)
        sendSubviewToBack(backgroundView)
        addSubview(scrollView)
        
        furtherQuestionsView.addSubview(furtherQuestionsLabel)
        
        scrollView.addSubview(welcomeLabel)
        scrollView.addSubview(wrapperView)
        wrapperView.addSubview(stackView)
        
        stackView.alignment = .center
        
        stackView.addArrangedSubview(challengesHeading)
        stackView.addArrangedSubview(challengesLabel)
        stackView.addArrangedSubview(impactHeading)
        stackView.addArrangedSubview(impactLabel)
        stackView.addArrangedSubview(recommendHeading)
        stackView.addArrangedSubview(recommendLabel)
        stackView.addArrangedSubview(reputableHeading)
        stackView.addArrangedSubview(reputableLabel)
        stackView.addArrangedSubview(furtherQuestionsView)
        
        setupLayout()
    }
    
    private func setupLayout() {
        
        let constraints = [
            welcomeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: spacing),
            welcomeLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            //furtherQuestionsLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            wrapperView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: spacing),
            wrapperView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            wrapperView.widthAnchor.constraint(equalTo: widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            
            challengesHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            challengesHeading.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            challengesLabel.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: labelMultiplier),
            
            impactHeading.heightAnchor.constraint(equalToConstant: headingHeight),
            impactHeading.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            impactLabel.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: labelMultiplier),
            
            recommendHeading.heightAnchor.constraint(equalToConstant: headingHeight * 2),
            recommendHeading.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            recommendLabel.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: labelMultiplier),
            
            reputableHeading.heightAnchor.constraint(equalToConstant: headingHeight * 2),
            reputableHeading.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            reputableLabel.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: labelMultiplier),
            
            furtherQuestionsView.heightAnchor.constraint(equalToConstant: headingHeight * 2.5),
            furtherQuestionsView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            furtherQuestionsLabel.centerXAnchor.constraint(equalTo: furtherQuestionsView.centerXAnchor),
            furtherQuestionsLabel.centerYAnchor.constraint(equalTo: furtherQuestionsView.centerYAnchor),
            furtherQuestionsLabel.widthAnchor.constraint(equalTo: furtherQuestionsView.widthAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeLabel(label: UILabel, text: String, font: UIFont, color: UIColor, _ addBackground: Bool) {
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = text
        label.font = font
        label.textColor = color
        if addBackground {
            label.backgroundColor = UIColor(red: 0.941, green: 0.969, blue: 0.929, alpha: 1)
        }
    }
    
    func setLabels() {
        changeLabel(label: welcomeLabel, text: "Welcome to The Good Fridge Help Center 👋", font: UIFont(name: "Amiko-SemiBold", size: 16)!, color: .black, false)
        
        changeLabel(label: challengesLabel, text: "Challenges are mini milestones that you can opt in to hold yourself accountable on your journey to become an ethical consumer. Each challenge falls under one of the three categories— human rights, environmental sustainability, and animal welfare.\n\nEach level of a challenge is completed when you buy a specified number of ethical products required for that level. You can view your progress towards your current challenge, as well as view the challenges you have completed already under your personal profile tab.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black, true)
        
        changeLabel(label: impactLabel, text: "Each time you accomplish a challenge, you can view the positive impact that you are able to make on the world under your personal profile tab.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black, true)
        
        changeLabel(label: recommendLabel, text: "So how do you know that you can trust us in helping you make ethical decisions? We try to prove to you that we are trustworthy by being 100% transparent about the way this app works.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black, true)
        
        changeLabel(label: reputableLabel, text: "There are a ton of ethical labels and certifications out there, but some are more trustworthy and reputable than others. We help you navigate the sea of choices by doing the research for you! We created a list of labels and certifications that are frequently cited by media and academia, and widely used to gauge whether a product is ethical.", font: UIFont(name: "Amiko-Regular", size: 12)!, color: .black, true)
    }
    
    func changeHeading(view: UIView, text: String, bgColor: UIColor) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = bgColor
        
        let label = UILabel()
        
        changeLabel(label: label, text: ("    " + text), font: UIFont(name: "Amiko-SemiBold", size: 14)!, color: .black, false)
        view.addSubview(label)
        
        
        let constraints = [
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: labelMultiplier)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setHeadings() {
        changeHeading(view: challengesHeading, text: "What are challenges?", bgColor: UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1))
        changeHeading(view: impactHeading, text: "How do I find out the impact I’m making?", bgColor: UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1))
        changeHeading(view: recommendHeading, text: "How do we choose which products to\n    recommend?", bgColor: UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1))
        changeHeading(view: reputableHeading, text: "How do we determine which ethical\n    labels are reputable and trustworthy?", bgColor: UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1))
    }
 
    func setupScrollView() {
        //Add and setup scroll view
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        //Add and setup stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 22;
        stackView.alignment = .center
        stackView.backgroundColor = .clear

    }
    
}

