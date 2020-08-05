//
//  ProfileViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/22/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

//var prevView = UIView()
//var currView = UIView()
//
//var ppage = ProfilePageView()
//var challenges = UIButton()
//var progress = UIButton()
//var stats = UIButton()
//var backButton = UIButton()
//var settingsButton = UIButton()
//let nameLabel = UILabel()
//
//let wrapperView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//} ()


class ProfileViewController: UIViewController {
    
//    var prevView = UIView()
//    var currView = UIView()

    
    var ppage = ProfilePageView()
    var settingsPage = SettingsView()
    
    
    
    
//    var challenges = UIButton()
//    var progress = UIButton()
//    var stats = UIButton()
//    var backButton = UIButton()
    
    
    
    
    
//    var settingsButton = UIButton()
//    let nameLabel = UILabel()

    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    
    let testView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    } ()

//    let settingsSymbol: UIButton = {
//        let button = UIButton()
//        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
//        button.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
//        return button
//    } ()
//    
//    let blankLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        return label
//    } ()
//    
//    let blankLabelEnd: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        return label
//    } ()
    
    
    
    
    
    
    
    
//    let backgroundImage: UIImageView = {
//        let img = UIImageView()
//        img.image = UIImage(named: "ProfileBackgroundImage")
//
//        return img
//    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ppage.translatesAutoresizingMaskIntoConstraints = false
//        ppage.setViewController(pvc: self)
        
        
        ppage.settingsSymbol.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
        
        settingsPage.backButton.addTarget(self, action: #selector(settingsPageTappedBackButton), for: .touchUpInside)
        
        //view.backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)

        
//        changeName()

//        ppage.nameStack.addArrangedSubview(blankLabel)
//        ppage.nameStack.addArrangedSubview(nameLabel)
//        ppage.nameStack.addArrangedSubview(settingsSymbol)
//        ppage.nameStack.addArrangedSubview(blankLabelEnd)
//        ppage.nameStack.alignment = .center
//        nameLabel.textAlignment = .center
        //ppage = ProfilePageView()
        
        
        wrapperView.addSubview(ppage)
        settingsPage.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addSubview(settingsPage)
        settingsPage.isHidden = true
        view.addSubview(wrapperView)
        setupLayout()
    }
    
    private func setupLayout() {
        let constraints = [
            
            wrapperView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            ppage.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0),
            ppage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0),
            ppage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0),
            ppage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0)
            
            
            
            
            
            
//            blankLabel.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 2/15),
//            blankLabel.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 0),
//            blankLabel.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: 0),
//
//            nameLabel.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 11/15),
//            nameLabel.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 0),
//            nameLabel.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: 0),
//
//            //settingsSymbol.trailingAnchor.constraint(equalTo: ppage.nameStack.trailingAnchor, constant: 0),
//            settingsSymbol.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 20),
//            settingsSymbol.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: -20),
//            settingsSymbol.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 1/15),
//
//            blankLabelEnd.widthAnchor.constraint(equalTo: ppage.nameStack.widthAnchor, multiplier: 1/15),
//            blankLabelEnd.topAnchor.constraint(equalTo: ppage.nameStack.topAnchor, constant: 0),
//            blankLabelEnd.bottomAnchor.constraint(equalTo: ppage.nameStack.bottomAnchor, constant: 0)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
        settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
        settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    }
    
//    func switchToSettingsPage() {
//        ppage.isHidden = true
//        wrapperView.addSubview(settingsPage)
//
//        let constraints = [
//            settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0),
//            settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0),
//            settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0),
//            settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0)
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//
//    }
    
    @objc func tappedSettingsButton() {
        
        print("Tapped Settings Button")
        
        //ppage.removeFromSuperview()
        
        ppage.isHidden = true
        settingsPage.isHidden = false
        
//        settingsPage.translatesAutoresizingMaskIntoConstraints = false
//        wrapperView.addSubview(settingsPage)
//        settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
//        settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
//        settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
//        settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true

    }
    
    @objc func settingsPageTappedBackButton() {
        
        settingsPage.isHidden = true
        ppage.isHidden = false
//        settingsPage.removeFromSuperview()
//        ppage = ProfilePageView()
//        ppage.translatesAutoresizingMaskIntoConstraints = false
//        wrapperView.addSubview(ppage)
//        ppage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
//        ppage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
//        ppage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
//        ppage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    }
    
    
    func setView(view: UIView) {
        settingsPage.translatesAutoresizingMaskIntoConstraints = false
        settingsPage = SettingsView()
        wrapperView.addSubview(settingsPage)
        settingsPage.topAnchor.constraint(equalTo: wrapperView.topAnchor).isActive = true
        settingsPage.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor).isActive = true
        settingsPage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor).isActive = true
        settingsPage.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor).isActive = true
    }
    
    
//    func createButtons(_ name: String) -> UIButton {
//        let button = UIButton()
//        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 15)
//        button.setTitle(name, for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.contentHorizontalAlignment = .center
//        return button
//    }
//
//    func declareAllButtons() {
//        challenges = createButtons("Challenges")
//        progress = createButtons("Progress")
//        stats = createButtons("Stats")
//        challenges.contentEdgeInsets.left = 5
//        progress.contentEdgeInsets.left = 10
//        stats.contentEdgeInsets.left = -15
//    }
    
    
    
    
    
    
//    func changeName() {
//        //get name of user
//        nameLabel.font = UIFont(name: "Amiko-Regular", size: 25)
//        nameLabel.textColor = UIColor.black
//        nameLabel.text = "Maddie Boesen"
//    }
//
//    @objc func tappedSettingsButton() {
//        prevView = ppage
//        currView = SettingsView()
//        ppage.removeFromSuperview()
//        setView(view: currView)
        
        
        
        
        
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
//            settingsVC.backingImage = self.tabBarController?.view.asImage()
//            self.present(settingsVC, animated: false, completion: nil)
//        })
//    }
    
//    func setView(view: UIView) {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        wrapperView.addSubview(view)
//        view.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0).isActive = true
//        view.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0).isActive = true
//        view.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0).isActive = true
//        view.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0).isActive = true
//    }
    

}
