//
//  DivePresentationView.swift
//  Scuba Companion
//
//  Created by Gage Fonk on 11/15/21.
//

import UIKit

class DivePresentationView: UIViewController {
    
    //declare variables
    
    let diveLogVM: DiveLogViewModel
    let diveIndex: Int
    let mainCard = DivePresentationCard(cardType: .main)
    let waterCard = DivePresentationCard(cardType: .water)
    let weatherCard = DivePresentationCard(cardType: .weather)
    let gearCard = DivePresentationCard(cardType: .gear)
    let gasCard = DivePresentationCard(cardType: .gas)
    let otherCard = DivePresentationCard(cardType: .other)
    var cards: [UIView] = []
    
    //scrollview
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        
        return scrollView
    }()
    
    let contentView = UIView()
    
    init(diveLogVM: DiveLogViewModel, diveIndex: Int){
        self.diveLogVM = diveLogVM
        self.diveIndex = diveIndex
        cards = [mainCard, waterCard, weatherCard, gearCard, gasCard, otherCard]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBackground
        view.isOpaque = false
        
        //navigation items
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editDiveButtonClicked))
        //add views
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainCard)
        contentView.addSubview(waterCard)
        contentView.addSubview(weatherCard)
        contentView.addSubview(gearCard)
        contentView.addSubview(gasCard)
        contentView.addSubview(otherCard)
        
        //populate fields
        updateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //constrain scroll
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        for (index, card) in cards.enumerated() {
            card.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 {
                card.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            } else {
                card.topAnchor.constraint(equalTo: cards[index - 1].bottomAnchor, constant: 10).isActive = true
            }
            if index == cards.endIndex - 1 {
                card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
            }
            card.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
            card.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    @objc private func editDiveButtonClicked() {
        let diveView = DiveView(diveLogViewModel: diveLogVM, edit: true, index: diveIndex)
        navigationController?.pushViewController(diveView, animated: true)
    }
    
    func updateView() {
        let dive = diveLogVM.dives[diveIndex]
        let date = diveLogVM.getFormattedDate(date: dive.date!)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //set title
            self.title = dive.title
            //main card
            self.mainCard.siteLabel.text = "Site: \(dive.site ?? "")"
            self.mainCard.dateLabel.text = "\(date)"
            //water card
            self.waterCard.diveTypeLabel.text = "Type: \(self.getDisplayStringForType(type: .diveType, dive: dive))"
            self.waterCard.waterTypeLabel.text = "Water: \(self.getDisplayStringForType(type: .waterType, dive: dive))"
            self.waterCard.maxDepthLabel.text = "Max: \(dive.maxDepth) ft"
            self.waterCard.waterBodyLabel.text = "Body: \(self.getDisplayStringForType(type: .waterBody, dive: dive))"
            self.waterCard.bottomTimeLabel.text = "Length: \(dive.diveLength) min"
            self.waterCard.visLabel.text = "Vis Type: \(dive.visibility)"
            self.waterCard.visInMLabel.text = "Vis: \(dive.visibilityInMeters) ft"
            self.waterCard.waveLabel.text = "Waves: \(self.getDisplayStringForType(type: .waves, dive: dive))"
            self.waterCard.currentLabel.text = "Current: \(self.getDisplayStringForType(type: .current, dive: dive))"
            self.waterCard.surgeLabel.text = "Surge: \(self.getDisplayStringForType(type: .surge, dive: dive))"
            
            //weather card
            self.weatherCard.weatherLabel.text = "Weather: \(self.getDisplayStringForType(type: .diveWeather, dive: dive))"
            self.weatherCard.airTempLabel.text = "Air: \(dive.airTemp) F"
            self.weatherCard.surfaceTempLabel.text = "Surface: \(dive.surfaceTemp) F"
            self.weatherCard.bottomTempLabel.text = "Bottom: \(dive.bottomTemp) F"
            
            //gear card
            self.gearCard.suitLabel.text = "Suit Type: \(self.getDisplayStringForType(type: .suitType, dive: dive))"
            self.gearCard.weightLabel.text = "Weight: \(dive.weight) lbs"
            self.gearCard.tankTypeLabel.text = "Tank: \(self.getDisplayStringForType(type: .tankType, dive: dive))"
            self.gearCard.tankSizeLabel.text = "Tank Size: \(dive.tankSize) L"
            
            //gas card
            self.gasCard.gasLabel.text = "Gas: \(self.getDisplayStringForType(type: .gasMixture, dive: dive))"
            self.gasCard.oxygenLabel.text = "Oxygen: \(dive.oxygen) %"
            self.gasCard.nitrogenLabel.text = "Nitrogen: \(dive.nitrogen) %"
            self.gasCard.heliumLabel.text = "Helium: \(dive.helium) %"
            self.gasCard.startPressureLabel.text = "Start: \(dive.startPressure) PSI"
            self.gasCard.endPressureLabel.text = "End: \(dive.endPressure) PSI"
            self.gasCard.amountUsedLabel.text = "Amount Used: \(dive.amountUsed) PSI"
            
            //other card
            self.otherCard.buddyLabel.text = "Buddies: \(dive.diveBuddy ?? "")"
            self.otherCard.centerLabel.text = "Dive Center: \(dive.diveCenter ?? "")"
            self.otherCard.noteLabel.text = "Notes: \(dive.note ?? "")"
        }
    }
    
    private func getDisplayStringForType(type: DiveLogInputType, dive: DiveModel) -> String {
        var value: String = ""
        switch type {
        case .diveType:
            for (index, type) in DiveType.allCases.enumerated() where index == dive.diveType {
                value = type.rawValue
            }
        case .waterType:
            for (index, type) in WaterType.allCases.enumerated() where index == dive.waterType {
                value = type.rawValue
            }
        case .waterBody:
            for (index, type) in WaterBody.allCases.enumerated() where index == dive.waterBody {
                value = type.rawValue
            }
        case .diveWeather:
            for (index, type) in DiveWeather.allCases.enumerated() where index == dive.diveWeather {
                value = type.rawValue
            }
        case .diveVisibility:
            for (index, type) in DiveVisibility.allCases.enumerated() where index == dive.visibility {
                value = type.rawValue
            }
        case .waves:
            for (index, type) in Waves.allCases.enumerated() where index == dive.waves {
                value = type.rawValue
            }
        case .current:
            for (index, type) in Current.allCases.enumerated() where index == dive.current {
                value = type.rawValue
            }
        case .surge:
            for (index, type) in Surge.allCases.enumerated() where index == dive.surge {
                value = type.rawValue
            }
        case .suitType:
            for (index, type) in SuitType.allCases.enumerated() where index == dive.suitType {
                value = type.rawValue
            }
        case .tankType:
            for (index, type) in TankType.allCases.enumerated() where index == dive.tankType {
                value = type.rawValue
            }
        case .gasMixture:
            for (index, type) in GasMixture.allCases.enumerated() where index == dive.gasMixture {
                value = type.rawValue
            }
        }
        return value
    }
    
}
