//
//  DiveLogFormCards.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/10/21.
//

import UIKit

class DiveLogFormCard: UIView {
    
    //declare variables
    let id: String
    let diveLogType: DiveLogType
    let titleLabel: DiveLogLabel
    let subtitleLabel: DiveLogLabel
    var unitLabel: DiveLogLabel?
    var inputField: DiveLogInputField?
    var datePicker: DiveLogDatePicker?
    var slider: DiveLogSlider?
    var sliderLabel: DiveLogLabel?
    var optionPicker: DiveLogPicker?
    var segmentControl: DiveLogSegment?
    
    init(diveLogType: DiveLogType, title: String, subtitle: String, id: String) {
        self.id = id
        self.diveLogType = diveLogType
        self.titleLabel = DiveLogLabel(text: title, style: .title2)
        self.titleLabel.textColor = .systemPrimary
        self.subtitleLabel = DiveLogLabel(text: subtitle, style: .headline)
        super.init(frame: .zero)
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, units: String, placeholder: String, id: String) {
        self.init(diveLogType: diveLogType, title: title, subtitle: subtitle, id: id)
        self.unitLabel = DiveLogLabel(text: units, style: .headline)
        self.inputField = DiveLogInputField(placeholder: placeholder)
        
        guard let unitLabel = unitLabel, let inputField = inputField else { return }
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(unitLabel)
        self.addSubview(inputField)
    }
    
    convenience init(diveLogType: DiveLogType, isDate: Bool, title: String, subtitle: String, id: String) {
        self.init(diveLogType: diveLogType, title: title, subtitle: subtitle, id: id)
        datePicker = DiveLogDatePicker()
        
        guard let datePicker = datePicker else { return }
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(datePicker)
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, segmentType: DiveLogInputType, id: String) {
        self.init(diveLogType: diveLogType, title: title, subtitle: subtitle, id: id)
        segmentControl = DiveLogSegment(type: segmentType)
        
        guard let segmentControl = segmentControl else { return }
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(segmentControl)
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, units: String, sliderType: DiveSliderType, id: String) {
        self.init(diveLogType: diveLogType, title: title, subtitle: subtitle, id: id)
        unitLabel = DiveLogLabel(text: units, style: .headline)
        slider = DiveLogSlider(type: sliderType)
        sliderLabel = DiveLogLabel(text: String(slider?.value ?? 0), style: .headline)
        
        guard let unitLabel = unitLabel, let slider = slider, let sliderLabel = sliderLabel else { return }
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(unitLabel)
        self.addSubview(slider)
        self.addSubview(sliderLabel)
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, pickerType: DivePickerType, id: String) {
        self.init(diveLogType: diveLogType, title: title, subtitle: subtitle, id: id)
        optionPicker = DiveLogPicker(type: pickerType)
        
        guard let optionPicker = optionPicker else { return }
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(optionPicker)
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
        
        //constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topPadding).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: topPadding).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        
        switch diveLogType {
        case .input:
            guard let unitLabel = unitLabel, let inputField = inputField else { return }
            unitLabel.translatesAutoresizingMaskIntoConstraints = false
            unitLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            unitLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            unitLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
            unitLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
            
            inputField.translatesAutoresizingMaskIntoConstraints = false
            inputField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            inputField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            inputField.rightAnchor.constraint(equalTo: unitLabel.leftAnchor, constant: rightPadding).isActive = true
            inputField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .slider:
            guard let sliderLabel = sliderLabel, let unitLabel = unitLabel, let slider = slider else { return }
            sliderLabel.translatesAutoresizingMaskIntoConstraints = false
            sliderLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            sliderLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            
            unitLabel.translatesAutoresizingMaskIntoConstraints = false
            unitLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            unitLabel.leftAnchor.constraint(equalTo: sliderLabel.rightAnchor, constant: leftPadding / 4).isActive = true
            unitLabel.bottomAnchor.constraint(equalTo: sliderLabel.bottomAnchor).isActive = true
            
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: topPadding).isActive = true
            slider.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            slider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            slider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .date:
            guard let datePicker = datePicker else { return }
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            datePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            datePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .segment:
            guard let segmentControl = segmentControl else { return }
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
            segmentControl.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            segmentControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            segmentControl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            segmentControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .picker:
            guard let optionPicker = optionPicker else { return }
            
            optionPicker.translatesAutoresizingMaskIntoConstraints = false
            optionPicker.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            optionPicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            optionPicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            optionPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        }
        
        //bg design
        self.backgroundColor = .surfaceBackground
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    @objc private func sliderValueChanged() {
        guard let slider = slider, let sliderLabel = sliderLabel else { return }
        let value: Float
        switch slider.type {
        case .maxDepth, .time, .temp, .vis, .weight, .tank:
            value = round(slider.value)
        case .gas, .pressure:
            let step: Float = 10
            value = round(slider.value / step) * step
        }
        
        slider.setValue(value, animated: false)
        sliderLabel.text = String(value)
    }
    
}
