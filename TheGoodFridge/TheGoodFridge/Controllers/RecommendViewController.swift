//
//  RecommendViewController.swift
//  TheGoodFridge
//
//  Created by Eugene Lo on 6/22/20./Users/owner/Desktop/TheGoodFridge/app-tgf/TheGoodFridge/TheGoodFridge/Views
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class RecommendViewController: UIViewController {

    let dimmerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
//    let cardView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    let handleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.518, green: 0.749, blue: 0.412, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var cardView = RecommendCardView(item: item, products: products)
    
    var backingImage: UIImage?
    var item = ""
    var products = [String]()
    var selectedProduct: String?
    var delegate: ProductDelegate?
    
    //lazy var cardViewTop = cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
    lazy var cardViewHeight = cardView.heightAnchor.constraint(equalToConstant: 0.0)
    lazy var cardPanStartingTopHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.size.height - 30.0
    
    override func viewDidLoad() {
        cardView = RecommendCardView(item: item, products: products)
        cardView.setSelected(product: selectedProduct)
        super.viewDidLoad()
        
        backingImageView.image = backingImage
        
        let dimmerTap = UITapGestureRecognizer(target: self, action: #selector(tappedDimmerTap))
        dimmerView.addGestureRecognizer(dimmerTap)
        dimmerView.isUserInteractionEnabled = true
        
        // pan gesture
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned))
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        self.view.addGestureRecognizer(viewPan)
        
        cardView.delegate = delegate
        view.addSubview(backingImageView)
        view.addSubview(dimmerView)
        view.addSubview(cardView)
        view.addSubview(handleView)
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showCard()
    }
    
    @objc func tappedDimmerTap() {
        hideCardAndGoBack()
    }
    
    @objc func viewPanned(_ panRecognizer: UIPanGestureRecognizer) {
        let translation = panRecognizer.translation(in: self.view)
        let velocity = panRecognizer.velocity(in: self.view)
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        
        switch panRecognizer.state {
        case .began:
            cardPanStartingTopHeight = cardViewHeight.constant
            handleView.alpha = 1.0
        case .changed:
            if cardPanStartingTopHeight - translation.y <= safeAreaHeight - 30.0 {
                self.cardViewHeight.constant = self.cardPanStartingTopHeight - translation.y
            }
            
            // change alpha according to position
            dimmerView.alpha = dimAlphaWithCardHeight(value: self.cardViewHeight.constant)
        case .ended:
            handleView.alpha = 0.7
            if velocity.y > 1500.0 {
                hideCardAndGoBack()
                return
            }
            
            if self.cardViewHeight.constant > (safeAreaHeight - 30.0) * 0.5 {
                showCard()
            } else {
                hideCardAndGoBack()
            }
        default:
            break
        }
    }
    
    private func setupLayout() {
        let handleViewWidth: CGFloat = 140.0
        let handleViewHeight: CGFloat = 3.0
        let handleViewOffset: CGFloat = 15.0
        
        let constraints = [
            dimmerView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardViewHeight,
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            handleView.widthAnchor.constraint(equalToConstant: handleViewWidth),
            handleView.heightAnchor.constraint(equalToConstant: handleViewHeight),
            handleView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            handleView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: handleViewOffset),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showCard() {
        // ensure there's no pending layout changes before animation runs
        self.view.layoutIfNeeded()
        
        cardViewHeight.constant = view.safeAreaLayoutGuide.layoutFrame.size.height - 30.0
        //cardView.scrollView.heightAnchor.constraint(equalToConstant: cardViewHeight.constant).isActive = true
        cardPanStartingTopHeight = cardViewHeight.constant
        
        let showCard = UIViewPropertyAnimator(duration: 0.30, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        showCard.addAnimations {
            self.dimmerView.alpha = 0.7
        }
        
        showCard.startAnimation()
    }
    
    private func hideCardAndGoBack() {
        self.view.layoutIfNeeded()
        
        cardViewHeight.constant = 0.0
        
        let hideCard = UIViewPropertyAnimator(duration: 0.25, curve: .easeIn, animations: {
            self.view.layoutIfNeeded()
        })
        
        hideCard.addAnimations {
            self.dimmerView.alpha = 0.0
        }
        
        hideCard.addCompletion({ position in
            if position == .end {
                if (self.presentingViewController != nil) {
                    self.dismiss(animated: false, completion: nil)
                }
            }
        })
        
        hideCard.startAnimation()
    }
    
    private func dimAlphaWithCardHeight(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = 0.7
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.size.height
        
        let fullDimPosition = safeAreaHeight - 30.0
        
        return fullDimAlpha * (value / fullDimPosition)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20.0
        cardView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        handleView.clipsToBounds = true
        handleView.layer.cornerRadius = handleView.frame.size.height / 2
    }

}
