//
//  ProfilePageView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ProfilePageView: UIView {
    
    class stack: UIStackView {
        var stck = UIStackView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.alignment = .center
            self.spacing = 0
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func changeAxisandDistribution(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution) {
            self.axis = axis
            self.distribution = distribution
        }
    }
    
    let profileStackView = stack()
    let upperStack = stack()
    let nameStack = stack()
    let lowerStack = stack()
    

    class CircularImageView: UIImageView {
        override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.cornerRadius = self.frame.size.height/2
            self.frame.size.width = self.frame.size.height
            self.contentMode = .scaleAspectFill
            self.clipsToBounds = true
        }
    }
    //profile picture
    let profilePicture: UIImageView = {
        let img = CircularImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "IssueButtonHighlighted")
        return img
    } ()
        
    //Segmented Tabs
    let tabsSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 50), buttonTitle: ["Challenges","Progress","Stats"])

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStackAttributes()
        addSubview(profileStackView)
        //Divides the page into 2
        profileStackView.addArrangedSubview(upperStack)
        
        tabsSegmented.backgroundColor = .clear
        profileStackView.addArrangedSubview(tabsSegmented)
        
        //profileStackView.addArrangedSubview(lowerStack)
        
        //Dividing the upper stack into 3 sections: person's name, person's image and tabs
        upperStack.addArrangedSubview(nameStack)
        
        upperStack.addArrangedSubview(profilePicture)
        setupLayoutPsv()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutPsv() {
        let constraints = [
            profileStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            profileStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            profileStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            profileStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            upperStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/4),
            upperStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            upperStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            nameStack.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 1/3),

            profilePicture.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 2/3),
            
            tabsSegmented.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tabsSegmented.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            //tabsSegmented.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/12),
            tabsSegmented.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 9/12)
            
            //lowerStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setStackAttributes() {
        profileStackView.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        upperStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        nameStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        lowerStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
    }
    
}
