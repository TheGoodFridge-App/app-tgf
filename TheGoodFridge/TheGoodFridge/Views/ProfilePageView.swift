//
//  ProfilePageView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ProfilePageView: UIView {
    
    let profileStackView: UIStackView = {
        let psv = UIStackView()
        psv.translatesAutoresizingMaskIntoConstraints = false
        psv.axis = .vertical
        psv.alignment = .center
        psv.distribution = .fill
        return psv
    } ()
    
    //Upper Stack
    let upperStack: UIStackView = {
        let uStack = UIStackView()
        uStack.translatesAutoresizingMaskIntoConstraints = false
        uStack.axis = .vertical
        uStack.alignment = .center
        uStack.distribution = .fill
        return uStack
    } ()
    
    
    //back button, name, settings
    let nameStack: UIStackView = {
        let nStack = UIStackView()
        nStack.translatesAutoresizingMaskIntoConstraints = false
        nStack.axis = .horizontal
        nStack.alignment = .center
        nStack.distribution = .fill
        return nStack
    } ()
    
    
    //profile picture
    let profilePicture: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    } ()
    
    
    //Has challenges, progress, stats
    let tabStack: UIStackView = {
        let tStack = UIStackView()
        tStack.translatesAutoresizingMaskIntoConstraints = false
        tStack.axis = .horizontal
        tStack.alignment = .center
        tStack.distribution = .fillEqually
        return tStack
    } ()
    
    let challenges = UIButton()
    let progress = UIButton()
    let stats = UIButton()
    
    
    //Lower Stack
    let lowerStack: UIStackView = {
        let lStack = UIStackView()
        lStack.translatesAutoresizingMaskIntoConstraints = false
        lStack.axis = .vertical
        lStack.alignment = .center
        lStack.distribution = .fill
        return lStack
    } ()
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileStackView)
        
        //Divides the page into 2
        profileStackView.addArrangedSubview(upperStack)
        profileStackView.addArrangedSubview(lowerStack)
        
        //Dividing the upper stack into 3 sections: person's name, person's image and tabs
        upperStack.addArrangedSubview(nameStack)
        
        
        upperStack.addArrangedSubview(profilePicture)
        
        
        upperStack.addArrangedSubview(tabStack)
        
        
        editButtons(button: challenges, name: "Challenges")
        editButtons(button: progress, name: "Progress")
        editButtons(button: stats, name: "Stats")
        challenges.contentEdgeInsets.left = 5
        progress.contentEdgeInsets.left = 10
        stats.contentEdgeInsets.left = -15
//        challenges.backgroundColor = .red
//        progress.backgroundColor = .blue
//        stats.backgroundColor = .green

        tabStack.addArrangedSubview(challenges)
        tabStack.addArrangedSubview(progress)
        tabStack.addArrangedSubview(stats)
        
        setupLayoutPsv()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutPsv() {
        let constraints = [
            profileStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            profileStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            profileStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            profileStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            upperStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3),
            lowerStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3),
            nameStack.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 7/16),
            profilePicture.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 7/16),
            tabStack.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 2/16),
            tabStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tabStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func editButtons(button: UIButton, name: String) {
        button.titleLabel?.font = UIFont(name: "Amiko-Regular", size: 15)
        button.setTitle(name, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .center
    }
    
}
