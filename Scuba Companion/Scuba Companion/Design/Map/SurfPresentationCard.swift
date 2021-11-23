//
//  SurfPresentation.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/17/21.
//

import UIKit

class SurfPresentationCard: UIView {
    
    let id: String
    let titleLabel: SurfLabel
    let subtitleLabel: SurfLabel
    let type: SurfCardType
    var dateView: SurfLabel?
    var progressView: SurfProgressView?
    let radius = UIScreen.main.bounds.width / 8
    
    init(type: SurfCardType, title: String, subtitle: String, id: String) {
        self.type = type
        self.id = id
        titleLabel = SurfLabel(text: title, style: .title2, color: .systemPrimary)
        subtitleLabel = SurfLabel(text: subtitle, style: .headline, color: .white)
        super.init(frame: .zero)
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
    }
    
    convenience init(type: SurfCardType, date: String, id: String) {
        self.init(type: type, title: "", subtitle: "", id: date)
        
        dateView = SurfLabel(text: date, style: .title1, color: .systemPrimary)
        
        guard let dateView = dateView else { return }
        
        self.addSubview(dateView)
    }
    
    convenience init(type: SurfCardType, title: String, subtitle: String, maxValue: Int, value: Int, id: String) {
        self.init(type: type, title: title, subtitle: subtitle, id: id)
        
        
        progressView = SurfProgressView(maxValue: maxValue, value: value)
        
        guard let progressView = progressView else { return }
        
        self.addSubview(progressView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftPadding: CGFloat = 20
        let rightPadding: CGFloat = -20
        let topPadding: CGFloat = 10
        let bottomPadding: CGFloat = -20
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        
        switch type {
        case .progress:
            guard let progressView = progressView else { return }
            progressView.createCircularPath(radius: radius)
            progressView.progressLayer.frame = self.bounds
            progressView.translatesAutoresizingMaskIntoConstraints = false
            progressView.heightAnchor.constraint(equalToConstant: radius * 2.1).isActive = true
            progressView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            progressView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            progressView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            progressView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
            
        case .date:
            dateView?.textAlignment = .center
            dateView?.translatesAutoresizingMaskIntoConstraints = false
            dateView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
            dateView?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            dateView?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            dateView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .temp, .tide, .swell, .wind, .weather:
            break
        }
        
        //bg design
        self.backgroundColor = .surfaceBackground
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor

    }
    
}
