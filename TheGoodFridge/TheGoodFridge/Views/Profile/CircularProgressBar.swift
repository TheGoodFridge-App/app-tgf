//
//  CircularProgressBar.swift
//  TheGoodFridge
//
//  Created by Shrenik Kankaria on 7/31/20.
//  Copyright © 2020 Eugene Lo. All rights reserved.
//

import UIKit

class CircularProgressBar: UIView {
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Amiko-Regular", size: 20)
        label.textColor = .black
        label.text = "0/0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        setupView()
        setupLayout()
        bringSubviewToFront(progressLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var lineWidth:CGFloat = 12 {
        didSet{
            //foregroundLayer.lineWidth = lineWidth - (0.05 * lineWidth)
            backgroundLayer.lineWidth = lineWidth - (0.20 * lineWidth)
        }
    }
    
    public func setProgress(to progressConstant: Float, withAnimation: Bool) {
        
        var progress: Float {
            get {
                if progressConstant > 1 { return 1 }
                else if progressConstant < 0 { return 0 }
                else { return progressConstant }
            }
        }
        
        //foregroundLayer.strokeEnd = CGFloat(progress)
        
        if withAnimation {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.toValue = progress
            animation.duration = CFTimeInterval(exactly: progress) ?? 0.5
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            foregroundLayer.add(animation, forKey: "foregroundAnimation")
            
        }
    }
    
    private let foregroundLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var radius: CGFloat {
        get{
            if self.frame.width < self.frame.height { return (self.frame.width - lineWidth)/2 }
            else { return (self.frame.height - lineWidth)/2 }
        }
    }
    
    private var pathCenter: CGPoint{ get{ return self.convert(self.center, from:self.superview) } }
    private func makeBar(){
        self.layer.sublayers = nil
        drawBackgroundLayer()
        drawForegroundLayer()
    }
    
    private func drawBackgroundLayer(){
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        self.backgroundLayer.path = path.cgPath
        self.backgroundLayer.strokeColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
        self.backgroundLayer.lineWidth = lineWidth - (lineWidth * 20/100)
        self.backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
    }
    
    var color: CGColor?
    
    public func setBarColor(colorName: CGColor) {
        color = colorName
    }
    
    func setText(current: Int, total: Int) {
        progressLabel.text = "\(current)/\(total)"
    }
    
    private func drawForegroundLayer(){
        
        let startAngle: CGFloat = -CGFloat.pi / 2
        let endAngle = 3 * CGFloat.pi / 2
        
        let path = UIBezierPath(arcCenter: pathCenter, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        foregroundLayer.lineCap = CAShapeLayerLineCap.round
        foregroundLayer.path = path.cgPath
        foregroundLayer.lineWidth = lineWidth - (0.21 * lineWidth)
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.strokeColor = color
        foregroundLayer.strokeEnd = 0
        
        self.layer.addSublayer(foregroundLayer)
        
    }
    
    private func setupView() {
        makeBar()
    }
    
    private func setupLayout() {
        addSubview(progressLabel)
        
        let constraints = [
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    private var layoutDone = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !layoutDone {
            setupView()
            setupLayout()
            bringSubviewToFront(progressLabel)
            layoutDone = true
        }
        
    }
    
}
