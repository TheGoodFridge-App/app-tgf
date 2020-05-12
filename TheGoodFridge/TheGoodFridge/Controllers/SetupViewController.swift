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
    func tappedNextButton()
    func tappedBackButton()
}


class SetupViewController: UIViewController {

    var slides = [UIView]()
    var setupData = SetupData()
    var pageCount: Int = 0
    
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
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let valuesView = ValuesView()
        //slides.append(valuesView)
        valuesView.delegate = self
        //pageCount = slides.count
        
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        updateContent(with: valuesView)
        
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        
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
    }
    
    private func setupLayout() {
        let pageControlOffset: CGFloat = 90
        
        let constraints = [
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
        let valuesArr = Array(values).sorted()
        for value in valuesArr {
            let type: ValueType
            switch value {
            case 0:
                type = .environment
                setupData.setEnvironment()
            case 1:
                type = .animal
                setupData.setAnimal()
            case 2:
                type = .human
                setupData.setHuman()
            default:
                type = .error
                debugPrint("Invalid integer for values")
                break
            }
            
            let issuesView = IssuesView(type: type)
            updateContent(with: issuesView)
        }
        
        // TODO: add finish view here
    }
    
    func tappedNextButton() {
        if index < slides.count - 1 {
            index += 1
            scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(index), y: 0), animated: true)
            pageControl.currentPage = index
        }
    }
    
    func tappedBackButton() {
        if index > 0 {
            index -= 1
        }
    }
    
}
