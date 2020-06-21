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
    let buttonWidth: CGFloat = 150
    let buttonHeight: CGFloat = 150
    let buttonSpacing: CGFloat = 25
    let scrollMargin: CGFloat = 5

    // Properties
    var issues = [String]()
    var icons = [String]()
    let type: ValueType
    let valueStr: String
    var selectedIssues = [Int]()
    
    // Delegate
    var delegate: SlideDelegate?
    
//    let setupBackground: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "SetupBackground2")
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        let bigText = NSMutableAttributedString(
            string: "You picked \(valueStr).\nWhat are some issues that you care about?",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 20)!]
        )
        let smallText = NSAttributedString(
            string: "\n\nPlease feel free to select multiple options.",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-Regular", size: 12)!]
        )
        bigText.append(smallText)
        textView.attributedText = bigText
        textView.textAlignment = .center
        return textView
    }()
    
    let nextButton: NextBackButton = {
        let button = NextBackButton(type: .next)
        button.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: NextBackButton = {
        let button = NextBackButton(type: .back)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    let collectionView: UICollectionView
    
    required init(type: ValueType) {
        self.type = type
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: buttonSpacing - scrollMargin, bottom: buttonSpacing, right: buttonSpacing - scrollMargin)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        if type == .environment {
            valueStr = "environment"
        } else if type == .animal {
            valueStr = "animal rights"
        } else {
            valueStr = "human rights"
        }
        
        //issues = IssueData.getAllIssues(values: values)
        super.init(frame: .zero)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IssueCell.self, forCellWithReuseIdentifier: K.issueCellID)
        collectionView.canCancelContentTouches = true
        collectionView.delaysContentTouches = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        
        addSubview(introTextView)
        addSubview(collectionView)
        addSubview(nextButton)
        addSubview(backButton)
//        addSubview(setupBackground)
        
//        sendSubviewToBack(setupBackground)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let textMargin: CGFloat = 70
        let spacing: CGFloat = 15
        let navButtonWidth: CGFloat = 130
        let navButtonHeight: CGFloat = 50
        let navButtonSpacing: CGFloat = 140
        let navButtonMargin: CGFloat = 50
        
        let constraints = [
//            setupBackground.topAnchor.constraint(equalTo: topAnchor),
//            setupBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
//            setupBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
//            setupBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 2 * buttonHeight + 2 * buttonSpacing),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: scrollMargin),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -scrollMargin),
            introTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            introTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textMargin),
            introTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -textMargin),
            introTextView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -spacing),
            backButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            backButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -navButtonSpacing),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: navButtonMargin),
            nextButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -navButtonSpacing),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -navButtonMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedGoalButton(sender: ValueGoalButton) {
        if sender.isSelected() {
            selectedIssues = selectedIssues.filter({$0 != sender.tag})
        } else {
            selectedIssues.append(sender.tag)
        }
        sender.toggle()
    }
    
    @objc func tappedNextButton() {
        delegate?.setIssues(type: type, issues: Set(selectedIssues))
        delegate?.tappedNextButton()
    }
    
    @objc func tappedBackButton() {
        delegate?.tappedBackButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
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
        cell.setImages(to: UIImage(named: icons[indexPath.item]))
        cell.goalButton.tag = indexPath.item
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
