//
//  ChallengeSetupView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class ChallengeSetupView: UIView {
    // Constants
    let buttonWidth: CGFloat = 140
    let buttonHeight: CGFloat = 140
    let buttonSpacing: CGFloat = 25
    let scrollMargin: CGFloat = 5

    // Properties
    var challenges: [ValueType: [String]]
    var challengesArr: [(String, ValueType)]
    var selectedChallenges = [Int]()
    // Delegate
    var slideDelegate: SlideDelegate?
    var challengeDelegate: ChallengeDelegate?
    var heldChallengeIndex: Int?
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        let bigText = NSMutableAttributedString(
            string: "Choose three challenges out of the following:",
            attributes: [NSAttributedString.Key.font: UIFont(name: "Amiko-SemiBold", size: 20)!]
        )
        let smallText = NSAttributedString(
            string: "\n\nTap to select, and tap and hold to learn more!",
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
    
    required init(challenges: [ValueType: [String]]) {
        self.challenges = challenges
        self.challengesArr = challenges.reduce([]) { cur, dict in
            return cur + dict.value.map({ ($0, dict.key) })
        }
        challengesArr = []
        if let e = challenges[.environment], let a = challenges[.animal], let h = challenges[.human] {
            challengesArr = e.map({($0, .environment)}) + a.map({($0, .animal)}) + h.map({($0, .human)})
        }
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: buttonSpacing - scrollMargin, bottom: buttonSpacing, right: buttonSpacing - scrollMargin)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        //issues = IssueData.getAllIssues(values: values)
        super.init(frame: .zero)

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChallengeSetupCell.self, forCellWithReuseIdentifier: K.challengeCellID)
        collectionView.canCancelContentTouches = true
        collectionView.delaysContentTouches = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        
        nextButton.isEnabled = false
        
        addSubview(introTextView)
        addSubview(collectionView)
        addSubview(nextButton)
        addSubview(backButton)
        
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
    
    @objc func tappedChallengeButton(sender: ChallengeButton) {
        if sender.isSelected() {
            selectedChallenges = selectedChallenges.filter({$0 != sender.tag})
        } else {
            selectedChallenges.append(sender.tag)
        }
        sender.setSelected(!sender.isSelected())
        nextButton.isEnabled = selectedChallenges.count > 0
        print(selectedChallenges)
    }
    
    @objc func tappedNextButton() {
        //delegate?.setIssues(type: type, issues: Set(selectedIssues))
        slideDelegate?.tappedNextButton()
    }
    
    @objc func tappedBackButton() {
        slideDelegate?.tappedBackButton()
    }
    
    @objc func heldChallenge(_ sender: UIGestureRecognizer) {
        if sender.state == .began {
            if let cellView = sender.view {
                let tag = cellView.tag
                let originInRootView = collectionView.convert(cellView.frame, to: self)
                print(originInRootView.origin)
                animatePopup(from: originInRootView)
                heldChallengeIndex = tag
                let (challenge, _) = challengesArr[tag]
                challengeDelegate?.heldChallenge(challenge: challenge)
            }
        }
    }
    
    private func animatePopup(from startFrame: CGRect) {
        let centerOrigin = CGPoint(x: startFrame.origin.x + (buttonWidth / 2), y: startFrame.origin.y + (buttonHeight / 2))
        let realFrame = CGRect(origin: centerOrigin, size: CGSize(width: 0, height: 0))
        let challengePopupView = ChallengePopupView(frame: realFrame)
        addSubview(challengePopupView)
        
        self.layoutIfNeeded()
        
        // Set new frame
        let popupWidth: CGFloat = frame.width
        let popupHeight: CGFloat = 0.5 * frame.height
        
        let showPopup = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations: {
            challengePopupView.frame = CGRect(x: 0, y: (self.frame.height - popupHeight) / 2,
            width: popupWidth, height: popupHeight)
            self.layoutIfNeeded()
        })
        
        showPopup.startAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nextButton.layer.cornerRadius = nextButton.frame.size.height / 2
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
    }
    
}

// MARK: - UICollectionViewDataSource
extension ChallengeSetupView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.challengeCellID, for: indexPath) as! ChallengeSetupCell
        // Set text according to value in challenges array
        let (text, type) = challengesArr[indexPath.item]
        cell.setText(to: text)

        // Set background image according to ValueType
        cell.setBackgroundImages(type: type)
        cell.challengeButton.tag = indexPath.item
        cell.tag = indexPath.item
        cell.challengeButton.addTarget(self, action: #selector(tappedChallengeButton), for: .touchUpInside)
        
        // Handler for button hold
        let buttonHold = UILongPressGestureRecognizer(target: self, action: #selector(heldChallenge))
        buttonHold.minimumPressDuration = 0.5
        cell.addGestureRecognizer(buttonHold)
        
        // Set selected if it exists in selected challenges (necessary because of collection view refresh behavior)
        if selectedChallenges.contains(indexPath.item) {
            cell.challengeButton.setSelected(true)
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ChallengeSetupView: UICollectionViewDelegateFlowLayout {
    
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
