//
//  IssuesView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class IssuesView: UIView {
    // Constants
    let buttonWidth: CGFloat = 140
    let buttonHeight: CGFloat = 120
    let buttonSpacing: CGFloat = 25
    let scrollMargin: CGFloat = 5

    // Properties
    let issues: [String]
    let type: ValueType
    let valueStr: String
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        let bigText = NSMutableAttributedString(
            string: "You picked \(valueStr)!\n\nWhat are some specific issues important to you?",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 20)!]
        )
        textView.attributedText = bigText
        textView.textAlignment = .center
        return textView
    }()
    
    let collectionView: UICollectionView
    
    required init(type: ValueType) {
        self.type = type
        //self.values = values
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: buttonSpacing - scrollMargin, bottom: buttonSpacing, right: buttonSpacing - scrollMargin)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        if type == .environment {
            valueStr = "environment"
            issues = IssueData.getEnvironmentIssues()
        } else if type == .animal {
            valueStr = "animal rights"
            issues = IssueData.getAnimalIssues()
        } else {
            valueStr = "human rights"
            issues = IssueData.getHumanIssues()
        }
        
        //issues = IssueData.getAllIssues(values: values)
        super.init(frame: .zero)
        
        //generateValueString()
        
        //translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IssueCell.self, forCellWithReuseIdentifier: K.issueCellID)
        collectionView.canCancelContentTouches = true
        collectionView.delaysContentTouches = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        
        addSubview(introTextView)
        addSubview(collectionView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let textMargin: CGFloat = 70
        let spacing: CGFloat = 45
        
        let constraints = [
            collectionView.heightAnchor.constraint(equalToConstant: 2 * buttonHeight + 2 * buttonSpacing),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: scrollMargin),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -scrollMargin),
            introTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            introTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textMargin),
            introTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textMargin),
            introTextView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -spacing)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedGoalButton(sender: ValueGoalButton) {
        sender.toggle()
    }
    
}

// MARK: - UICollectionViewDataSource
extension IssuesView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return issues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.issueCellID, for: indexPath) as! IssueCell
        //let (text, type) = issues[indexPath.item] ?? ("", .error)
        let text = issues[indexPath.item]
        cell.setText(to: text)
        cell.setColor(type: type)
        cell.goalButton.addTarget(self, action: #selector(tappedGoalButton), for: .touchUpInside)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension IssuesView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension IssuesView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: buttonWidth, height: buttonHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return buttonSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return buttonSpacing
    }
    
}
