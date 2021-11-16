//
//  DivePresentationCard.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/15/21.
//

import UIKit

enum PresentationType: String {
    case main = "Dive Info", water = "Water Info", weather = "Weather Info", gear = "Gear Info", gas = "Gas Info", other = "Miscellaneous"
}

class DivePresentationCard: UIView {
    
    let cardType: PresentationType
    
    //views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .systemPrimary
        
        return label
    }()
    let siteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let diveTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let maxDepthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let bottomTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let waterTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let waterBodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let airTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let surfaceTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let bottomTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let visLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let visInMLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let waveLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let currentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let surgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let suitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let tankTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let tankSizeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let gasLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let oxygenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let nitrogenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let heliumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let startPressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let endPressureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let amountUsedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .errorColor
        
        return label
    }()
    let buddyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    let centerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    let noteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        
        return label
    }()
    
    required init(cardType: PresentationType) {
        self.cardType = cardType
        super.init(frame: .zero)
        titleLabel.text = cardType.rawValue
        self.addSubview(titleLabel)
        self.addSubview(siteLabel)
        self.addSubview(dateLabel)
        self.addSubview(diveTypeLabel)
        self.addSubview(maxDepthLabel)
        self.addSubview(bottomTimeLabel)
        self.addSubview(waterTypeLabel)
        self.addSubview(waterBodyLabel)
        self.addSubview(weatherLabel)
        self.addSubview(airTempLabel)
        self.addSubview(surfaceTempLabel)
        self.addSubview(bottomTempLabel)
        self.addSubview(visLabel)
        self.addSubview(visInMLabel)
        self.addSubview(waveLabel)
        self.addSubview(currentLabel)
        self.addSubview(surgeLabel)
        self.addSubview(suitLabel)
        self.addSubview(weightLabel)
        self.addSubview(tankTypeLabel)
        self.addSubview(tankSizeLabel)
        self.addSubview(gasLabel)
        self.addSubview(oxygenLabel)
        self.addSubview(nitrogenLabel)
        self.addSubview(heliumLabel)
        self.addSubview(startPressureLabel)
        self.addSubview(endPressureLabel)
        self.addSubview(amountUsedLabel)
        self.addSubview(buddyLabel)
        self.addSubview(centerLabel)
        self.addSubview(noteLabel)
        self.addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftPadding: CGFloat = 20
        let leftHalfPadding: CGFloat = 10
        let rightPadding: CGFloat = -20
        let rightHalfPadding: CGFloat = -10
        let topPadding: CGFloat = 10
        let bottomPadding: CGFloat = -20
        
        //constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        
        switch cardType {
        case .main:
            siteLabel.translatesAutoresizingMaskIntoConstraints = false
            siteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            siteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            siteLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            siteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
            
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            dateLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .water:
            diveTypeLabel.translatesAutoresizingMaskIntoConstraints = false
            diveTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            diveTypeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            diveTypeLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            waterTypeLabel.translatesAutoresizingMaskIntoConstraints = false
            waterTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            waterTypeLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            waterTypeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            maxDepthLabel.translatesAutoresizingMaskIntoConstraints = false
            maxDepthLabel.topAnchor.constraint(equalTo: diveTypeLabel.bottomAnchor, constant: topPadding).isActive = true
            maxDepthLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            maxDepthLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            waterBodyLabel.translatesAutoresizingMaskIntoConstraints = false
            waterBodyLabel.topAnchor.constraint(equalTo: waterTypeLabel.bottomAnchor, constant: topPadding).isActive = true
            waterBodyLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            waterBodyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            bottomTimeLabel.translatesAutoresizingMaskIntoConstraints = false
            bottomTimeLabel.topAnchor.constraint(equalTo: maxDepthLabel.bottomAnchor, constant: topPadding).isActive = true
            bottomTimeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            bottomTimeLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            visLabel.translatesAutoresizingMaskIntoConstraints = false
            visLabel.topAnchor.constraint(equalTo: waterBodyLabel.bottomAnchor, constant: topPadding).isActive = true
            visLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            visLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            visInMLabel.translatesAutoresizingMaskIntoConstraints = false
            visInMLabel.topAnchor.constraint(equalTo: bottomTimeLabel.bottomAnchor, constant: topPadding).isActive = true
            visInMLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            visInMLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            waveLabel.translatesAutoresizingMaskIntoConstraints = false
            waveLabel.topAnchor.constraint(equalTo: visLabel.bottomAnchor, constant: topPadding).isActive = true
            waveLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            waveLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            currentLabel.translatesAutoresizingMaskIntoConstraints = false
            currentLabel.topAnchor.constraint(equalTo: visInMLabel.bottomAnchor, constant: topPadding).isActive = true
            currentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            currentLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            surgeLabel.translatesAutoresizingMaskIntoConstraints = false
            surgeLabel.topAnchor.constraint(equalTo: waveLabel.bottomAnchor, constant: topPadding).isActive = true
            surgeLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            surgeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            surgeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .weather:
            weatherLabel.translatesAutoresizingMaskIntoConstraints = false
            weatherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            weatherLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            weatherLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            airTempLabel.translatesAutoresizingMaskIntoConstraints = false
            airTempLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            airTempLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            airTempLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            surfaceTempLabel.translatesAutoresizingMaskIntoConstraints = false
            surfaceTempLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: topPadding).isActive = true
            surfaceTempLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            surfaceTempLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            surfaceTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
            
            bottomTempLabel.translatesAutoresizingMaskIntoConstraints = false
            bottomTempLabel.topAnchor.constraint(equalTo: airTempLabel.bottomAnchor, constant: topPadding).isActive = true
            bottomTempLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            bottomTempLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            bottomTempLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .gear:
            suitLabel.translatesAutoresizingMaskIntoConstraints = false
            suitLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            suitLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            suitLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            weightLabel.translatesAutoresizingMaskIntoConstraints = false
            weightLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            weightLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            weightLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            tankTypeLabel.translatesAutoresizingMaskIntoConstraints = false
            tankTypeLabel.topAnchor.constraint(equalTo: suitLabel.bottomAnchor, constant: topPadding).isActive = true
            tankTypeLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            tankTypeLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            tankTypeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
            
            tankSizeLabel.translatesAutoresizingMaskIntoConstraints = false
            tankSizeLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: topPadding).isActive = true
            tankSizeLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            tankSizeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            tankSizeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .gas:
            gasLabel.translatesAutoresizingMaskIntoConstraints = false
            gasLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            gasLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            gasLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            oxygenLabel.translatesAutoresizingMaskIntoConstraints = false
            oxygenLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            oxygenLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            oxygenLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            nitrogenLabel.translatesAutoresizingMaskIntoConstraints = false
            nitrogenLabel.topAnchor.constraint(equalTo: gasLabel.bottomAnchor, constant: topPadding).isActive = true
            nitrogenLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            nitrogenLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            heliumLabel.translatesAutoresizingMaskIntoConstraints = false
            heliumLabel.topAnchor.constraint(equalTo: oxygenLabel.bottomAnchor, constant: topPadding).isActive = true
            heliumLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            heliumLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            startPressureLabel.translatesAutoresizingMaskIntoConstraints = false
            startPressureLabel.topAnchor.constraint(equalTo: nitrogenLabel.bottomAnchor, constant: topPadding).isActive = true
            startPressureLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            startPressureLabel.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: rightHalfPadding).isActive = true
            
            endPressureLabel.translatesAutoresizingMaskIntoConstraints = false
            endPressureLabel.topAnchor.constraint(equalTo: heliumLabel.bottomAnchor, constant: topPadding).isActive = true
            endPressureLabel.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: leftHalfPadding).isActive = true
            endPressureLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            amountUsedLabel.translatesAutoresizingMaskIntoConstraints = false
            amountUsedLabel.topAnchor.constraint(equalTo: startPressureLabel.bottomAnchor, constant: topPadding).isActive = true
            amountUsedLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            amountUsedLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            amountUsedLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .other:
            centerLabel.translatesAutoresizingMaskIntoConstraints = false
            centerLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
            centerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            centerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            buddyLabel.translatesAutoresizingMaskIntoConstraints = false
            buddyLabel.topAnchor.constraint(equalTo: centerLabel.bottomAnchor, constant: topPadding).isActive = true
            buddyLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            buddyLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            
            noteLabel.translatesAutoresizingMaskIntoConstraints = false
            noteLabel.topAnchor.constraint(equalTo: buddyLabel.bottomAnchor, constant: topPadding).isActive = true
            noteLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            noteLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            noteLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        }
        
        //bg design
        self.backgroundColor = .surfaceBackground
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}
