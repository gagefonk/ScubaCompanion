//
//  DiveLogFormCards.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/10/21.
//

import UIKit

class DiveLogInputCard: UIView, UITextFieldDelegate {
    
    let title: String = ""
    let subtitle: String = ""
    let placeholder: String = ""
    let units: String = ""
    var charType: CharType = .all
    var stringInput = true
    var numberInput = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let inputField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .clear
        field.layer.borderColor = UIColor.systemGreen.cgColor
        field.borderStyle = .roundedRect
        field.textColor = .white
        field.leftViewMode = .always
        field.rightViewMode = .always
        field.isUserInteractionEnabled = true
        
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isOpaque = false
        inputField.delegate = self
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(unitLabel)
        addSubview(inputField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCard(charType: CharType, title: String, subtitle: String, units: String, placeholder: String) {
        //set values
        titleLabel.text = title
        subtitleLabel.text = subtitle
        inputField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        unitLabel.text = units
        self.charType = charType
        
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
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch charType {
        case .floatType:
            let allowedCharacters = CharacterSet(charactersIn: ".0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        case .intType:
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        case .all, .none:
            return true
        }
    }
    
}

class DiveLogDateCard: UIView {
    
    let title: String = ""
    let subtitle: String = ""
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isOpaque = false
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(datePicker)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCard(title: String, subtitle: String) {
        //set values
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
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
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
        datePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        datePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
    }
    
}

class DiveLogTypeCard: UIView {
    
    let title: String = ""
    let subtitle: String = ""
    let placeholder: String = ""
    let units: String = ""
    var items: [NSEnumerator] = []
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.selectedSegmentTintColor = .systemBlue
        
        return segment
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isOpaque = false
        
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(segmentControl)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureCard(title: String, subtitle: String, type: LogInputTypes) {
        //set values
        titleLabel.text = title
        subtitleLabel.text = subtitle
        setPickerOptions(type: type)
        
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
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: topPadding).isActive = true
        segmentControl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftPadding).isActive = true
        segmentControl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: rightPadding).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding).isActive = true
    }
    
    private func setPickerOptions(type: LogInputTypes) {
        switch type {
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
        case .none:
            return
        }
        
        segmentControl.selectedSegmentIndex = 0
    }
}
