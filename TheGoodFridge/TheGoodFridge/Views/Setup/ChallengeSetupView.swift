//
//  ChallengeSetupView.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/10/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

protocol ChallengeDelegate {
    func didGetDescriptions(descriptions: [String: Content])
    func selectedChallenge(challenge: String?)
}

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
    var descriptions = [String: Content]()
    // Delegate
    var slideDelegate: SlideDelegate?
    var heldChallengeIndex: Int?
    
    lazy var introTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        let bigText = NSMutableAttributedString(
            string: "Choose up to three challenges out of the following:",
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
    
    let backingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dimmerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.alpha = 0.0
        return view
    }()
    
    let collectionView: UICollectionView
    let challengePopupView = ChallengePopupView()
    let challengeManager = ChallengeManager()
    
    required init(challenges: [ValueType: [String]]) {
        self.challenges = challenges
        self.challengesArr = challenges.reduce([]) { cur, dict in
            return cur + dict.value.map({ ($0, dict.key) })
        }
        challengesArr = []
        if let e = challenges[.environment], let a = challenges[.animal], let h = challenges[.human] {
            challengesArr = e.map({($0, .environment)}) + a.map({($0, .animal)}) + h.map({($0, .human)})
        }
        
        // Collection view layout setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: buttonSpacing - scrollMargin, bottom: buttonSpacing, right: buttonSpacing - scrollMargin)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        //issues = IssueData.getAllIssues(values: values)
        super.init(frame: .zero)
        
        challengeManager.delegate = self
        challengeManager.getDescriptions(challenges: challengesArr.map({(challenge, _) in challenge}))
        
        challengePopupView.delegate = self

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ChallengeSetupCell.self, forCellWithReuseIdentifier: K.challengeCellID)
        collectionView.canCancelContentTouches = true
        collectionView.delaysContentTouches = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .clear
        
        nextButton.isEnabled = false
        
        //Dimmer view tap setup
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(tappedDimmerView))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
        
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
        let textMargin: CGFloat = 50
        let spacing: CGFloat = 10
        let navButtonWidth: CGFloat = 130
        let navButtonHeight: CGFloat = 50
        let navButtonSpacing: CGFloat = 25
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
            backButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: navButtonSpacing),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: navButtonMargin),
            nextButton.heightAnchor.constraint(equalToConstant: navButtonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: navButtonWidth),
            nextButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: navButtonSpacing),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -navButtonMargin)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func tappedChallengeButton(sender: ChallengeButton) {
        if sender.isSelected() {
            selectedChallenges = selectedChallenges.filter({$0 != sender.tag})
            sender.setSelected(false)
        } else if selectedChallenges.count < 3 {
            selectedChallenges.append(sender.tag)
            sender.setSelected(true)
        }
        
        nextButton.isEnabled = selectedChallenges.count > 0
    }
    
    @objc func tappedNextButton() {
        nextButton.isEnabled = false
        let selected = Set<Int>(selectedChallenges)
        var actualChallenges = [String]()
        
        for num in selected {
            actualChallenges.append(challengesArr[num].0)
        }
        
        var formattedChallenges = challenges
        
        for value in formattedChallenges {
            var key = ValueType.error
            switch value.key {
            case .environment:
                key = .environment
            case .animal:
                key = .animal
            case .human:
                key = .human
            default:
                break
            }
            
            formattedChallenges[key] = formattedChallenges[key]?.filter({ actualChallenges.contains($0) }) ?? []
        }
        slideDelegate?.setChallenges(challenges: formattedChallenges)
        slideDelegate?.tappedNextButton()
        nextButton.isEnabled = true
    }
    
    @objc func tappedBackButton() {
        backButton.isEnabled = false
        slideDelegate?.tappedBackButton()
        backButton.isEnabled = true
    }
    
    @objc func heldChallenge(_ sender: UIGestureRecognizer) {
        if sender.state == .began {
            if let cellView = sender.view {
                let tag = cellView.tag
                let originInRootView = collectionView.convert(cellView.frame, to: self)
                
                // Disable buttons
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.backButton.isEnabled = false
                    self.nextButton.isEnabled = false
                })
                
                // Set backing image
                backingImageView.image = self.parentContainerViewController()?.view.asImage()
                backingImageView.isHidden = false
                
                addSubview(backingImageView)
                addSubview(dimmerView)
                
                let constraints = [
                    dimmerView.topAnchor.constraint(equalTo: topAnchor),
                    dimmerView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    dimmerView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    dimmerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    backingImageView.topAnchor.constraint(equalTo: topAnchor),
                    backingImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    backingImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    backingImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
                ]
                
                NSLayoutConstraint.activate(constraints)
                self.layoutIfNeeded()
                
                animatePopup(from: originInRootView, index: tag)
            }
        }
    }
    
    @objc func tappedDimmerView(_ tapRecognizer: UITapGestureRecognizer) {
        hidePopup()
    }
    
    private func animatePopup(from startFrame: CGRect, index: Int) {
        // Set popup start position
        let (challenge, type) = challengesArr[index]
        //let realFrame = CGRect(origin: centerOrigin, size: CGSize(width: 0, height: 0))
        challengePopupView.frame = startFrame
        challengePopupView.layer.cornerRadius = startFrame.height / 2
        challengePopupView.alpha = 0.0
        self.challengePopupView.startFrame = startFrame
        challengePopupView.setInfo(challenge: challenge, type: type)
        // Set description if it exists in map
        if let description = descriptions[challenge] {
            challengePopupView.setDescription(to: description)
        }
        addSubview(challengePopupView)
        
        self.layoutIfNeeded()
        
        // Set new frame
        let popupWidth: CGFloat = frame.width
        let popupHeight: CGFloat = (7/12) * frame.height
        let margin: CGFloat = 25
        
        let showPopup = UIViewPropertyAnimator(duration: 0.20, curve: .easeOut, animations: {
            self.dimmerView.alpha = 0.2
            self.challengePopupView.alpha = 1.0
            self.challengePopupView.frame = CGRect(x: margin, y: (self.frame.height - popupHeight) / 2,
            width: popupWidth - (2 * margin), height: popupHeight)
            self.bringSubviewToFront(self.challengePopupView)
            self.layoutIfNeeded()
        })
        
        showPopup.startAnimation()
    }
    
    private func hidePopup() {
        nextButton.isEnabled = selectedChallenges.count > 0
        backButton.isEnabled = true
        
        // Hide popup first
        let hideCard = UIViewPropertyAnimator(duration: 0.2, curve: .easeOut) {
            self.layoutIfNeeded()
        }
        hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
            self.challengePopupView.frame = self.challengePopupView.startFrame
            self.challengePopupView.alpha = 0.0
            self.backingImageView.isHidden = true
        }
        
        hideCard.startAnimation()
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

extension ChallengeSetupView: ChallengeDelegate {
    func selectedChallenge(challenge: String?) {
        if challenge != nil && selectedChallenges.count < 3 {
            if let index = challengesArr.firstIndex(where: { (c, _) in challenge == c }) {
                if !selectedChallenges.contains(index) {
                    selectedChallenges.append(index)
                    collectionView.reloadData()
                }
            }
        }
        
        hidePopup()
    }
    
    func didGetDescriptions(descriptions: [String: Content]) {
        self.descriptions.merge(descriptions, uniquingKeysWith: { (_, new) in new })
        if let challenge = challengePopupView.curChallenge, let description = descriptions[challenge] {
            challengePopupView.setDescription(to: description)
        } else {
            challengePopupView.setDescription(to: Content(name: "", description: "Error: Could not load description", impact: []))
        }
    }
}
