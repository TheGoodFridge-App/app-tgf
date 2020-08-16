//
//  SetupViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

protocol SlideDelegate {
    func setValues(values: Set<Int>)
    func setIssues(type: ValueType, issues: Set<Int>)
    func setChallenges(challenges: [ValueType: [String]])
    func tappedNextButton()
    func tappedBackButton()
    func tappedStartButton()
}

protocol SetupDelegate {
    func receivedChallenges(challenges: [ValueType: [String]])
    func postedSetupData()
}

class SetupViewController: UIViewController {

    var slides = [UIView]()
    var setupData = SetupData()
    var pageCount: Int = 0
    var selectedValues = Set<Int>()
    var selectedIssues = [ValueType: Set<Int>]()
    var selectedChallenges = [(ValueType, String)]()
    var issuesPageCount = 0
    var curIssuesPageCount = 0
    
    let setupBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SetupBackground1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.isPagingEnabled = true
        sv.isScrollEnabled = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    var index = 0
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.pageIndicatorTintColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
        pc.currentPageIndicatorTintColor = .black
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .darkGray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let valuesView = ValuesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData.delegate = self
        view.backgroundColor = .white
        
        //slides.append(valuesView)
        valuesView.delegate = self
        //pageCount = slides.count
        
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        updateContent(with: valuesView)
        
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        view.addSubview(spinner)
        
        view.addSubview(setupBackground)
        
        view.sendSubviewToBack(setupBackground)
        
        setupLayout()
    }

    private func updateContent(with slide: UIView) {
        slides.append(slide)
        pageCount = slides.count
        pageControl.numberOfPages = pageCount
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pageCount), height: view.frame.height)
        
        //scrollView.delegate = self
        for i in 0..<pageCount {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
        
        view.bringSubviewToFront(pageControl)
    }
    
    private func setupLayout() {
        let pageControlOffset: CGFloat = 90
        
        let constraints = [
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            setupBackground.topAnchor.constraint(equalTo: view.topAnchor),
            setupBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            setupBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            setupBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -pageControlOffset),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

}

// MARK: - SlideDelegate
extension SetupViewController: SlideDelegate {
    
    func setValues(values: Set<Int>) {
        if selectedValues != values {
            selectedValues = values
            issuesPageCount = values.count
            let subviews = scrollView.subviews
            for subview in subviews {
                if subview != valuesView {
                    subview.removeFromSuperview()
                }
            }
            
            slides = Array(slides[0...0])
            pageCount = slides.count
            scrollView.contentSize = valuesView.frame.size
            
            setupData.unsetEnvironment()
            setupData.unsetAnimal()
            setupData.unsetHuman()
            
            let valuesArr = Array(values).sorted()
            for value in valuesArr {
                let type: ValueType
                var issues = [String]()
                var icons = [String]()
                
                switch value {
                case 0:
                    type = .environment
                    (issues, icons) = IssueData.getEnvironmentIssues()
                    setupData.setEnvironment()
                case 1:
                    type = .animal
                    (issues, icons) = IssueData.getAnimalIssues()
                    setupData.setAnimal()
                case 2:
                    type = .human
                    (issues, icons) = IssueData.getHumanIssues()
                    setupData.setHuman()
                default:
                    type = .error
                    debugPrint("Invalid integer for values")
                    break
                }
                
                let issuesView = IssuesView(type: type)
                issuesView.issues = issues
                issuesView.icons = icons
                issuesView.delegate = self
                updateContent(with: issuesView)
            }
            
//            let challengeIntroView = ChallengeIntroView()
//            challengeIntroView.delegate = self
//            updateContent(with: challengeIntroView)
            
//            let startView = StartView()
//            startView.delegate = self
//            updateContent(with: startView)
        }
        
    }
    
    func setIssues(type: ValueType, issues: Set<Int>) {
        let sortedIssues = Array(issues).sorted()
        
        selectedIssues[type] = issues
        setupData.setIssues(type: type, issues: sortedIssues)
        
        // Create challenge views
        
    }
    
    func setChallenges(challenges: [ValueType: [String]]) {
        var formattedChallenges = [(ValueType, String)]()
        for entry in challenges {
            for value in entry.value {
                formattedChallenges.append((entry.key, value))
            }
        }
        
        self.selectedChallenges = formattedChallenges
        var challengesStr = [String: [String]]()
        for entry in challenges {
            var strKey = "error"
            switch entry.key {
            case .environment:
                strKey = "environment"
            case .animal:
                strKey = "animal"
            case .human:
                strKey = "human"
            default:
                break
            }
            
            challengesStr[strKey] = challenges[entry.key]
        }
        setupData.setChallenges(challengesStr)
    }
    
    func tappedNextButton() {
        if index == slides.count - 1 && slides[index] is IssuesView {
            spinner.startAnimating()
            setupData.getChallenges()
            //setupData.postSetupData()
        } else if index < slides.count - 1 && slides[index] is IssuesView && slides[index + 1] is ChallengeIntroView {
            slides.removeAll(where: {$0 is ChallengeIntroView || $0 is ChallengeSetupView})
            spinner.startAnimating()
            setupData.getChallenges()
        } else if index < slides.count - 1 {
            if let challengeCompleteView = slides[index + 1] as? ChallengeCompleteView {
                challengeCompleteView.setChallenges(challenges: selectedChallenges)
            }
            index += 1
            scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(index), y: 0), animated: true)
        }
        
        pageControl.currentPage = index
    }
    
    func tappedBackButton() {
        if index > 0 {
            index -= 1
            scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(index), y: 0), animated: true)
            pageControl.currentPage = index
        }
    }
    
    func tappedStartButton() {
        spinner.startAnimating()
        setupData.postSetupData()
    }
    
}

extension SetupViewController: SetupDelegate {
    
    func receivedChallenges(challenges: [ValueType: [String]]) {
        spinner.stopAnimating()
        let challengeIntroView = ChallengeIntroView()
        challengeIntroView.delegate = self
        updateContent(with: challengeIntroView)
        
        let challengeSetupView = ChallengeSetupView(challenges: challenges)
        challengeSetupView.slideDelegate = self
        updateContent(with: challengeSetupView)
        
        let challengeCompleteView = ChallengeCompleteView()
        challengeCompleteView.delegate = self
        updateContent(with: challengeCompleteView)
        
        index += 1
        scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(index), y: 0), animated: true)
        pageControl.currentPage = index
    }
    
    func postedSetupData() {
        spinner.stopAnimating()
        
        let navigationVC = UINavigationController(rootViewController: TabBarController())
        navigationVC.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationVC.navigationBar.shadowImage = UIImage()
        navigationVC.navigationBar.isTranslucent = true
        navigationVC.view.backgroundColor = UIColor.clear
        navigationVC.modalPresentationStyle = .fullScreen

        DispatchQueue.main.async {
            self.present(navigationVC, animated: true, completion: nil)
        }
    }
    
}
