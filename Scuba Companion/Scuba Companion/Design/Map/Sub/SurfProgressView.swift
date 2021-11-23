//
//  SurfProgressView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/18/21.
//

import UIKit

class SurfProgressView: UIView {
    
    var circleLayer = CAShapeLayer()
    var progressLayer = CAShapeLayer()
    let label = UILabel()
    let maxValue: Int
    let value: Int
    
    init(maxValue: Int, value: Int) {
        self.maxValue = maxValue
        self.value = value
        label.text = String(value)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCircularPath(radius: CGFloat) {
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let startAngle: CGFloat = -(3 * .pi / 2)
        let endAngle: CGFloat = (.pi / 2)
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        circleLayer.path = progressPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 10.0
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = UIColor.darkBackground?.cgColor
        layer.addSublayer(circleLayer)
        
        progressLayer.path = progressPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 10.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.systemSecondary?.cgColor
        
        progressLayer.shadowOffset = .zero
        progressLayer.shadowColor = UIColor.systemSecondary?.cgColor
        progressLayer.shadowRadius = 5.0
        progressLayer.shadowOpacity = 1.0
        
        layer.addSublayer(progressLayer)
        
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //animate
        animateProgress()
    }
    
    func animateProgress() {
        let progressValue = Double(value) / Double(maxValue)
        
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 1.5
        circularProgressAnimation.fromValue = 0
        circularProgressAnimation.toValue = progressValue
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
}
