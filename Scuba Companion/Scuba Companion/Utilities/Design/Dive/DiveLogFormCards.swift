//
//  DiveLogFormCards.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/10/21.
//

import UIKit

class DiveLogFormCard: UIView, UITextFieldDelegate {
    
    //declare variables
    var isDecimal: Bool = true
    var id: String = ""
    var diveLogType: DiveLogType = .input
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPrimary
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    let inputField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .clear
        field.borderStyle = .roundedRect
        field.textColor = .white
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.isUserInteractionEnabled = true
        
        return field
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        slider.maximumTrackTintColor = .systemSecondary
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        return slider
    }()
    
    let sliderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.tintColor = .systemSecondary
        
        return datePicker
    }()
    
    let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.selectedSegmentTintColor = .systemSecondary
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        return segment
    }()
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, units: String, placeholder: String, id: String) {
        self.init(frame: .zero)
        
        self.addSubview(unitLabel)
        self.addSubview(inputField)
        
        inputField.delegate = self
        
        self.diveLogType = diveLogType
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.unitLabel.text = units
        inputField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        inputField.returnKeyType = .done
        self.id = id
        
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, units: String, isDecimal: Bool, minValue: Float, maxValue: Float, id: String){
        self.init(frame: .zero)
        
        self.addSubview(slider)
        self.addSubview(sliderLabel)
        self.addSubview(unitLabel)
        
        self.diveLogType = diveLogType
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.unitLabel.text = units
        self.isDecimal = isDecimal
        setSliderOptions(minValue: minValue, maxValue: maxValue)
        self.id = id
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, id: String) {
        self.init(frame: .zero)
        
        self.addSubview(datePicker)
        
        self.diveLogType = diveLogType
        titleLabel.text = title
        subtitleLabel.text = subtitle
        self.id = id
    }
    
    convenience init(diveLogType: DiveLogType, title: String, subtitle: String, segmentType: DiveLogInputType, id: String) {
        self.init(frame: .zero)
        
        self.addSubview(segmentControl)
        
        self.diveLogType = diveLogType
        titleLabel.text = title
        subtitleLabel.text = subtitle
        setPickerOptions(segmentType: segmentType)
        self.id = id
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isOpaque = false
        
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
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
            sliderLabel.translatesAutoresizingMaskIntoConstraints = false
            sliderLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
//            sliderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
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
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            datePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            datePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        case .segment:
            segmentControl.translatesAutoresizingMaskIntoConstraints = false
            segmentControl.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
            segmentControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
            segmentControl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
            segmentControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
        }
        
        //bg design
        self.backgroundColor = .surfaceBackground
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setSliderOptions(minValue: Float, maxValue: Float) {
        let setValue = ((maxValue + minValue) / 2).rounded()
        self.slider.minimumValue = minValue
        self.slider.maximumValue = maxValue
        self.slider.setValue(setValue, animated: true)
        self.sliderLabel.text = String(setValue)
    }
    
    @objc private func sliderValueChanged() {
        let value: Float
        if id == "startPressure" || id == "endPressure" {
            let step: Float = 10
            value = round(slider.value / step) * step
        } else {
            value = isDecimal ? round(slider.value * 10) / 10.0 :  round(slider.value)
        }
        slider.setValue(value, animated: false)
        sliderLabel.text = String(value)
    }
    
    private func setPickerOptions(segmentType: DiveLogInputType) {
        switch segmentType {
        case .diveType:
            for (index, type) in DiveType.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .waterType:
            for (index, type) in WaterType.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .waterBody:
            for (index, type) in WaterBody.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .diveWeather:
            for (index, type) in DiveWeather.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .diveVisibility:
            for (index, type) in DiveVisibility.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .waves:
            for (index, type) in Waves.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .current:
            for (index, type) in Current.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .surge:
            for (index, type) in Surge.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .suitType:
            for (index, type) in SuitType.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .tankType:
            for (index, type) in TankType.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        case .gasMixture:
            for (index, type) in GasMixture.allCases.enumerated() {
                segmentControl.insertSegment(withTitle: type.rawValue, at: index, animated: false)
            }
        }
        
        segmentControl.selectedSegmentIndex = 0
    }
    
}
