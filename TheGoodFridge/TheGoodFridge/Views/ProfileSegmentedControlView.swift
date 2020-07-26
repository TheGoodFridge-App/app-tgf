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
                btn.setTitleColor(selectorTextColor, for: .normal)
//                print(selectedIndex)
            }
        }
    }
}



//Configuration View
var stack = UIStackView(arrangedSubviews: [UIButton]())
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
        wrapStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        wrapStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
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
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/9).isActive = true
        
        let lowerStack = UIStackView()
        lowerStack.axis = .vertical
        lowerStack.alignment = .center
        lowerStack.distribution = .fill
        wrapStack.addArrangedSubview(lowerStack)
        lowerStack.translatesAutoresizingMaskIntoConstraints = false
        lowerStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        lowerStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        lowerStack.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 0).isActive = true
        lowerStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 8/9).isActive = true
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        lowerStack.addArrangedSubview(view)
        view.leftAnchor.constraint(equalTo: lowerStack.leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: lowerStack.rightAnchor, constant: 0).isActive = true
//        view.topAnchor.constraint(equalTo: lowerStack.topAnchor, constant: 0).isActive = true
//        view.bottomAnchor.constraint(equalTo: lowerStack.bottomAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalTo: lowerStack.heightAnchor, multiplier: 1).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count + 1)
//        print(frame.height)
//        print(stack.frame.height)
        selectorView = UIView(frame: CGRect(x: frame.width/24, y: stack.frame.height + 50, width: selectorWidth, height: 2))
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
