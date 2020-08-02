//
//  ProfileSegmentedControlView.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/26/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit
protocol CustomSegmentedControlDelegate:class {
    func change(to index:Int)
}

class CustomSegmentedControl: UIView {
    private var buttonTitles:[String]!
    private var buttons: [UIButton]!
    private var selectorView: UIView!
    
    var textColor: UIColor = .black
    var selectorViewColor: UIColor = .black
    var selectorTextColor: UIColor = .black
    
    weak var delegate:CustomSegmentedControlDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(frame:CGRect, buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
    func setIndex(index:Int) {
        buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
        let button = buttons[index]
        selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
            self.selectorView.frame.origin.x = selectorPosition
        }
    }
    
    var currIndex = 0
    let statsView = StatsView()
    let challengeView = ChallengeBoxes()
    
    func setLowerStackView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        lowerStack.addArrangedSubview(view)
        view.topAnchor.constraint(equalTo: lowerStack.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: lowerStack.bottomAnchor, constant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: lowerStack.leadingAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: lowerStack.trailingAnchor, constant: 0).isActive = true
    }
    
    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
                let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                selectedIndex = buttonIndex
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
                    self.selectorView.frame.origin.x = selectorPosition + self.frame.width/24
                }
//                let statsView = StatsView()
//                let challengeView = ChallengeBoxes()
                btn.setTitleColor(selectorTextColor, for: .normal)
                
                print(currIndex)

        
                if selectedIndex != currIndex {
                    switch currIndex {
                    case 0:
                        challengeView.removeFromSuperview()
                        
                    case 1:
                        statsView.removeFromSuperview()
                        
                    default:
                        print("Nothing Removed")
                    }
                }
                
                
                currIndex = selectedIndex
                switch selectedIndex {
                    
                case 0:
                    setLowerStackView(view: challengeView)
                    
                case 1:
                    setLowerStackView(view: statsView)
                    
                default:
                    print("Default case!")
                }
//                print(selectedIndex)
            }
        }
    }
}



//Configuration View
var stack = UIStackView(arrangedSubviews: [UIButton]())
var lowerStack = UIStackView()
extension CustomSegmentedControl {

    private func updateView() {
        createButton()
        configStackView()
        configSelectorView()
//        configStackView()
    }
  
    // (1/12) for tab and (8/12) for lower: 1/9, 8/9
    private func configStackView() {
        
        let wrapStack = UIStackView()
        wrapStack.axis = .vertical
        wrapStack.alignment = .center
        wrapStack.distribution = .fill
        addSubview(wrapStack)
        wrapStack.translatesAutoresizingMaskIntoConstraints = false
        wrapStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        //wrapStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        wrapStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        wrapStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        wrapStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
        stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        wrapStack.addArrangedSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        //stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/12).isActive = true
        
//        let lowerStack = UIStackView()
        lowerStack.axis = .vertical
        lowerStack.alignment = .center
        lowerStack.distribution = .fill
        wrapStack.addArrangedSubview(lowerStack)
        lowerStack.translatesAutoresizingMaskIntoConstraints = false
        lowerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        lowerStack.trailingAnchor.constraint(equalTo: wrapStack.trailingAnchor, constant: 0).isActive = true
        lowerStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 0).isActive = true
        lowerStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 11/12).isActive = true
        
        setLowerStackView(view: challengeView)
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count + 1)
//        print(frame.height)
//        print(stack.frame.height)
        selectorView = UIView(frame: CGRect(x: frame.width/24, y: stack.frame.height + 40, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.textAlignment = .center
            
//            button.layer.borderWidth = 2
//            button.layer.borderColor = CGColor.init(srgbRed: 0.8, green: 0.2, blue: 0.3, alpha: 1)
            
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
    }
    
    
}