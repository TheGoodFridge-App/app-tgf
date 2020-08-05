//
//  ProfilePageView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/24/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

//let pvc = ProfileViewController()

class ProfilePageView: UIView {
    
//    var pvc: ProfileViewController?
//
//    func setViewController(pvc: ProfileViewController) {
//        self.pvc = pvc
//    }
    
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
    
    
    
    
    
    var settingsButton = UIButton()
    let nameLabel = UILabel()

    let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        return view
    } ()

    let settingsSymbol: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "SettingsButton"), for: .normal)
//        button.addTarget(self, action: #selector(tappedSettingsButton), for: .touchUpInside)
        return button
    } ()
    
    let blankLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
    let blankLabelEnd: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    } ()
    
    func changeName() {
        //get name of user
        nameLabel.font = UIFont(name: "Amiko-Regular", size: 25)
        nameLabel.textColor = UIColor.black
        nameLabel.text = "Maddie Boesen"
    }
    
            
    
    
    
    

    class CircularImageView: UIImageView {
        override func layoutSubviews() {
            super.layoutSubviews()
            self.frame.size.height /= 1.25
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
        img.image = UIImage(named: "DefaultProfilePicture") //IssueButtonHighlighted
        return img
    } ()
    
    
        
    //Segmented Tabs
    let tabsSegmented = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 50), buttonTitle: ["Challenges","Stats"]) //"Archive"
    
    
    let fullPageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        return view
    } ()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        
        backgroundColor = #colorLiteral(red: 1, green: 0.9529411765, blue: 0.9019607843, alpha: 1)
        setStackAttributes()
        addSubview(fullPageView)
        fullPageView.addSubview(wrapperView)
        wrapperView.addSubview(profileStackView)
        //Divides the page into 2
        profileStackView.addArrangedSubview(upperStack)
        
        tabsSegmented.backgroundColor = .clear
        profileStackView.addArrangedSubview(tabsSegmented)
        
        //profileStackView.addArrangedSubview(lowerStack)
        
        //Dividing the upper stack into 3 sections: person's name, person's image and tabs
        upperStack.addArrangedSubview(nameStack)
        
        
        
        changeName()
        nameStack.addArrangedSubview(blankLabel)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(settingsSymbol)
        nameStack.addArrangedSubview(blankLabelEnd)
        nameStack.alignment = .center
        nameLabel.textAlignment = .center
        
        
        
        upperStack.addArrangedSubview(profilePicture)
        upperStack.alignment = .center
        
        //print(safeAreaLayoutGuide)
        
        setupLayoutPsv()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayoutPsv() {
        
        let constraints = [
            
            fullPageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            fullPageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            fullPageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            fullPageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            wrapperView.topAnchor.constraint(equalTo: fullPageView.safeAreaLayoutGuide.topAnchor, constant: 0),
            wrapperView.bottomAnchor.constraint(equalTo: fullPageView.bottomAnchor, constant: 0),
            wrapperView.leadingAnchor.constraint(equalTo: fullPageView.leadingAnchor, constant: 0),
            wrapperView.trailingAnchor.constraint(equalTo: fullPageView.trailingAnchor, constant: 0),
            
            profileStackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 0), //safeAreaLayoutGuide
            profileStackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: 0),
            profileStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 0),
            profileStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: 0),
            
            upperStack.heightAnchor.constraint(equalTo: profileStackView.heightAnchor, multiplier: 1/5),
            upperStack.leadingAnchor.constraint(equalTo: profileStackView.leadingAnchor, constant: 0),
            upperStack.trailingAnchor.constraint(equalTo: profileStackView.trailingAnchor, constant: 0),
            
            nameStack.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 5/12),
            nameStack.trailingAnchor.constraint(equalTo: profileStackView.trailingAnchor, constant: 0),
            nameStack.leadingAnchor.constraint(equalTo: profileStackView.leadingAnchor, constant: 0),

            profilePicture.heightAnchor.constraint(equalTo: upperStack.heightAnchor, multiplier: 7/12),
            profilePicture.leadingAnchor.constraint(equalTo: upperStack.leadingAnchor, constant: 150),
            
            tabsSegmented.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tabsSegmented.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tabsSegmented.topAnchor.constraint(equalTo: upperStack.bottomAnchor),
            
            //tabsSegmented.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/12),
            
            tabsSegmented.heightAnchor.constraint(equalTo: profileStackView.heightAnchor, multiplier: 4/5),
            
            //lowerStack.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3)
            
            
            
            
            blankLabel.widthAnchor.constraint(equalTo: nameStack.widthAnchor, multiplier: 2/15),
            blankLabel.topAnchor.constraint(equalTo: nameStack.topAnchor, constant: 0),
            blankLabel.bottomAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 0),
            
            nameLabel.widthAnchor.constraint(equalTo: nameStack.widthAnchor, multiplier: 11/15),
            nameLabel.topAnchor.constraint(equalTo: nameStack.topAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 0),
            
            //settingsSymbol.trailingAnchor.constraint(equalTo: ppage.nameStack.trailingAnchor, constant: 0),
            settingsSymbol.topAnchor.constraint(equalTo: nameStack.topAnchor, constant: 20),
            settingsSymbol.bottomAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: -20),
            settingsSymbol.widthAnchor.constraint(equalTo: nameStack.widthAnchor, multiplier: 1/15),
            
            blankLabelEnd.widthAnchor.constraint(equalTo: nameStack.widthAnchor, multiplier: 1/15),
            blankLabelEnd.topAnchor.constraint(equalTo: nameStack.topAnchor, constant: 0),
            blankLabelEnd.bottomAnchor.constraint(equalTo: nameStack.bottomAnchor, constant: 0)
            
            
            
            
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setStackAttributes() {
        profileStackView.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        upperStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
        nameStack.changeAxisandDistribution(axis: .horizontal, distribution: .fill)
        lowerStack.changeAxisandDistribution(axis: .vertical, distribution: .fill)
    }
    
//    @objc func tappedSettingsButton() {
////        profileStackView.removeFromSuperview()
////        wrapperView.isHidden = true
////        wrapperView.removeFromSuperview()
//
//        //pvc?.ppage.removeFromSuperview()
//
//        pvc?.switchToSettingsPage()
//
////        pvc?.ppage.isHidden = true
//
//
//        //pvc?.ppage = SettingsView()
//
//
//        pvc?.wrapperView.addSubview(pvc!.settingsPage)
//        setSettingsView()
//    }
    

//    func setView(view: UIView) {
//        view.translatesAutoresizingMaskIntoConstraints = false
//        pvc!.wrapperView.addSubview(view)
//        view.topAnchor.constraint(equalTo: pvc!.wrapperView.topAnchor, constant: 0).isActive = true
//        view.bottomAnchor.constraint(equalTo: pvc!.wrapperView.bottomAnchor, constant: 0).isActive = true
//        view.leadingAnchor.constraint(equalTo: pvc!.wrapperView.leadingAnchor, constant: 0).isActive = true
//        view.trailingAnchor.constraint(equalTo: pvc!.wrapperView.trailingAnchor, constant: 0).isActive = true
//    }
//
//    func setSettingsView() {
//        pvc!.settingsPage.topAnchor.constraint(equalTo: pvc!.wrapperView.topAnchor, constant: 0).isActive = true
//        pvc!.settingsPage.bottomAnchor.constraint(equalTo: pvc!.wrapperView.bottomAnchor, constant: 0).isActive = true
//        pvc!.settingsPage.leadingAnchor.constraint(equalTo: pvc!.wrapperView.leadingAnchor, constant: 0).isActive = true
//        pvc!.settingsPage.trailingAnchor.constraint(equalTo: pvc!.wrapperView.trailingAnchor, constant: 0).isActive = true
//    }

}
