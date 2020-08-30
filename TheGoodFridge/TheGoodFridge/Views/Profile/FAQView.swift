//
//  FAQView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 8/30/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class FAQView: UIView {
    
    let faqLabel = UILabel()
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        
        backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        
        setLabels()
        setHeadings()
        
        addSubview(wrapperView)
        addSubview(backgroundView)
        sendSubviewToBack(backgroundView)
        wrapperView.addSubview(backButton)
        wrapperView.addSubview(faqLabel)
        wrapperView.addSubview(welcomeLabel)
        wrapperView.addSubview(furtherQuestionsView)
        wrapperView.addSubview(scrollView)
        
        furtherQuestionsView.addSubview(furtherQuestionsLabel)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(challengesHeading)
        stackView.addArrangedSubview(challengesLabel)
        stackView.addArrangedSubview(impactHeading)
        stackView.addArrangedSubview(impactLabel)
        stackView.addArrangedSubview(recommendHeading)
        stackView.addArrangedSubview(recommendLabel)
        stackView.addArrangedSubview(reputableHeading)
        stackView.addArrangedSubview(reputableLabel)
        
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            wrapperView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            wrapperView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 24),
            backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 31.5),
            
            faqLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            faqLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -5),
            faqLabel.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: 27),
            
            welcomeLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: faqLabel.bottomAnchor, constant: 25),
            welcomeLabel.bottomAnchor.constraint(equalTo: faqLabel.bottomAnchor, constant: 45),
            
            //furtherQuestionsLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            furtherQuestionsView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
            furtherQuestionsView.topAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -60),
            furtherQuestionsView.widthAnchor.constraint(equalTo: wrapperView.widthAnchor),
            
            furtherQuestionsLabel.centerXAnchor.constraint(equalTo: furtherQuestionsView.centerXAnchor),
            furtherQuestionsLabel.centerYAnchor.constraint(equalTo: furtherQuestionsView.centerYAnchor, constant: 10),
            furtherQuestionsLabel.widthAnchor.constraint(equalTo: furtherQuestionsView.widthAnchor),
            //furtherQuestionsLabel.centerXAnchor.constraint(equalTo: furtherQuestionsView.centerXAnchor),
            
            
            
            
            scrollView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 21),
            scrollView.bottomAnchor.constraint(equalTo: furtherQuestionsView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            
            challengesHeading.heightAnchor.constraint(equalToConstant: 33),
            challengesHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            challengesLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            challengesLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            impactHeading.heightAnchor.constraint(equalToConstant: 33),
            impactHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            impactLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            impactLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            recommendHeading.heightAnchor.constraint(equalToConstant: 66),
            recommendHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            recommendLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            recommendLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
            
            reputableHeading.heightAnchor.constraint(equalToConstant: 66),
            reputableHeading.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            reputableLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 19),
            reputableLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -30),
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
        changeLabel(label: faqLabel, text: "FAQ", font: UIFont(name: "Amiko-Regular", size: 24)!, color: .black, false)
        
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
        scrollView.backgroundColor = UIColor(red: 0.941, green: 0.969, blue: 0.929, alpha: 1)

        //Add and setup stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 22;
        stackView.backgroundColor = .clear

    }
    
}

