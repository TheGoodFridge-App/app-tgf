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
    
    let accDetailsButton = UIButton()
    let currChallengesButton = UIButton()
    let faqButton = UIButton()
    let privacyButton = UIButton()
    let signOutButton = UIButton()
    
    let blankViewAboveAppSupport = UIView()
    let blankViewAboveSignOut = UIView()
    
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
        setButtonViews()
        setBlankViews()
        changeSignOutButton()
        
        addSubview(fullScreenView)
        fullScreenView.addSubview(wrapperView)
        //wrapperView.addSubview(settingsStack)
        wrapperView.addSubview(backButton)
        wrapperView.addSubview(settingsLabel)
        wrapperView.addSubview(settingsSymbol)
        wrapperView.addSubview(stackView)
        
        stackView.addArrangedSubview(myAccountLabel)
        stackView.addArrangedSubview(accDetailsButton)
        stackView.addArrangedSubview(currChallengesButton)
        stackView.addArrangedSubview(blankViewAboveAppSupport)
        stackView.addArrangedSubview(appSupportLabel)
        stackView.addArrangedSubview(faqButton)
        stackView.addArrangedSubview(privacyButton)
        stackView.addArrangedSubview(blankViewAboveSignOut)
        stackView.addArrangedSubview(signOutButton)
        
        
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

            
            backButton.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            backButton.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
            //backButton.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 74),
            //backButton.trailingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 26.5),
            
            settingsLabel.centerXAnchor.constraint(equalTo: fullScreenView.centerXAnchor),
            settingsLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            //settingsLabel.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 83),
            
            settingsSymbol.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            //settingsSymbol.bottomAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 80),
            settingsSymbol.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
            //settingsSymbol.leadingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -60),
            
            stackView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: wrapperView.safeAreaLayoutGuide.bottomAnchor, constant: -23),
            
            accDetailsButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            accDetailsButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            currChallengesButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            currChallengesButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            faqButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            faqButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            privacyButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            privacyButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            
            blankViewAboveAppSupport.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            blankViewAboveAppSupport.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            blankViewAboveSignOut.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            blankViewAboveSignOut.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            signOutButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            signOutButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
            
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
        changeLabel(label: myAccountLabel, text: "          MY ACCOUNT", font: UIFont(name: "Amiko-Bold", size: 14)!, color: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1))
        changeLabel(label: appSupportLabel, text: "          APP SUPPORT", font: UIFont(name: "Amiko-Bold", size: 14)!, color: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1))
    }
    
    func changeButtonView(button: UIButton, text: String) {
        let view = UIView()
        //let lineView = UIView()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
//        lineView.translatesAutoresizingMaskIntoConstraints = false
//        lineView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.37)
        let label = UILabel()
        changeLabel(label: label, text: text, font: UIFont(name: "Amiko-Regular", size: 14)!, color: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1))
        
        let img = UIImageView()
        let imgFrame = CGRect(x: 300, y: 25, width: 7.5, height: 12)
        img.image = UIImage(named: "NextButton")
        img.frame = imgFrame
        img.contentMode = .scaleAspectFill
        
        view.isUserInteractionEnabled = false
        
        view.addBorders(edges: [.top], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
        
        button.addSubview(view)
        //view.addSubview(lineView)
        view.addSubview(label)
        view.addSubview(img)
        
        let constraints = [
            view.topAnchor.constraint(equalTo: button.topAnchor),
            view.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: button.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
//            lineView.topAnchor.constraint(equalTo: view.topAnchor),
//            lineView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 1),
//            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func changeSignOutButton() {
        let view = UIView()
        //let lineView = UIView()
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.855, green: 0.925, blue: 0.824, alpha: 1)

        let label = UILabel()
        changeLabel(label: label, text: "SIGN OUT", font: UIFont(name: "Amiko-Bold", size: 14)!, color: UIColor(red: 0.424, green: 0.683, blue: 0.305, alpha: 1))
        
        view.addBorders(edges: [.top, .bottom], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
        
        view.isUserInteractionEnabled = false
        
        signOutButton.addSubview(view)
        //view.addSubview(lineView)
        view.addSubview(label)
                
        let constraints = [
            view.topAnchor.constraint(equalTo: signOutButton.topAnchor),
            view.bottomAnchor.constraint(equalTo: signOutButton.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: signOutButton.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: signOutButton.trailingAnchor),
        
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setButtonViews() {
        changeButtonView(button: accDetailsButton, text: "             ACCOUNT DETAILS")
        changeButtonView(button: currChallengesButton, text: "             CURRENT CHALLENGES")
        changeButtonView(button: faqButton, text: "             FAQ")
        changeButtonView(button: privacyButton, text: "             PRIVACY POLICY")
        
        
    }
    
    func setBlankViews() {
        blankViewAboveAppSupport.translatesAutoresizingMaskIntoConstraints = false
        blankViewAboveSignOut.translatesAutoresizingMaskIntoConstraints = false
        blankViewAboveAppSupport.addBorders(edges: [.top], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
        blankViewAboveSignOut.addBorders(edges: [.top], color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.37))
    }

}

extension UIView {
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {

        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }


        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }

        return borders
    }
}
