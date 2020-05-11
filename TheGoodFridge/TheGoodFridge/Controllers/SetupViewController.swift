//
//  SetupViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 5/5/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

protocol SlideDelegate {
    func updateData(values: [ValueType]?)
    func tappedNextButton()
    func tappedBackButton()
}


class SetupViewController: UIViewController {

    let valueView = ValuesView()
    let issuesView = IssuesView()
    lazy var slides = [valueView, issuesView]
    var setupData = SetupData()
    
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
        
        valueView.delegate = self
        
        setupScrollView()
        
        view.addSubview(pageControl)
        view.addSubview(scrollView)
        
        setupLayout()
    }
    
    private func setupScrollView() {
        let pageCount = slides.count
        pageControl.numberOfPages = pageCount
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        //scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        
        //scrollView.delegate = self
        for i in 0..<pageCount {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    private func setupLayout() {
        let pageControlOffset: CGFloat = 90
        
        print(slides[0].frame, slides[1].frame)
        
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
    
    func updateData(values: [ValueType]?) {
        if let values = values {
            setupData.values = values
            issuesView.values = values
            print(values)
        }
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
