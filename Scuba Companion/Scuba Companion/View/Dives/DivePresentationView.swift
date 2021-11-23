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
        let date = diveLogVM.getFormattedDate(date: dive.date)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            //set title
            self.title = dive.title
            //main card
            self.mainCard.siteLabel.text = "Site: \(dive.site)"
            self.mainCard.dateLabel.text = "\(date)"
            //water card
            self.waterCard.diveTypeLabel.text = "Type: \(dive.diveType.rawValue)"
            self.waterCard.waterTypeLabel.text = "Water: \(dive.waterType.rawValue)"
            self.waterCard.maxDepthLabel.text = "Max: \(dive.maxDepth) ft"
            self.waterCard.waterBodyLabel.text = "Body: \(dive.waterBody.rawValue)"
            self.waterCard.bottomTimeLabel.text = "Length: \(dive.diveLength) min"
            self.waterCard.visLabel.text = "Vis Type: \(dive.visibility.rawValue)"
            self.waterCard.visInMLabel.text = "Vis: \(dive.visibilityInMeters) ft"
            self.waterCard.waveLabel.text = "Waves: \(dive.waves.rawValue)"
            self.waterCard.currentLabel.text = "Current: \(dive.current.rawValue)"
            self.waterCard.surgeLabel.text = "Surge: \(dive.surge.rawValue)"
            
            //weather card
            self.weatherCard.weatherLabel.text = "Weather: \(dive.diveWeather.rawValue)"
            self.weatherCard.airTempLabel.text = "Air: \(dive.airTemp) F"
            self.weatherCard.surfaceTempLabel.text = "Surface: \(dive.surfaceTemp) F"
            self.weatherCard.bottomTempLabel.text = "Bottom: \(dive.bottomTemp) F"
            
            //gear card
            self.gearCard.suitLabel.text = "Suit Type: \(dive.suitType.rawValue)"
            self.gearCard.weightLabel.text = "Weight: \(dive.weight) lbs"
            self.gearCard.tankTypeLabel.text = "Tank: \(dive.tankType.rawValue)"
            self.gearCard.tankSizeLabel.text = "Tank Size: \(dive.tankSize) L"
            
            //gas card
            self.gasCard.gasLabel.text = "Gas: \(dive.gasMixture.rawValue)"
            self.gasCard.oxygenLabel.text = "Oxygen: \(dive.oxygen) %"
            self.gasCard.nitrogenLabel.text = "Nitrogen: \(dive.nitrogen) %"
            self.gasCard.heliumLabel.text = "Helium: \(dive.helium) %"
            self.gasCard.startPressureLabel.text = "Start: \(dive.startPressure) PSI"
            self.gasCard.endPressureLabel.text = "End: \(dive.endPressure) PSI"
            self.gasCard.amountUsedLabel.text = "Amount Used: \(dive.amountUsed) PSI"
            
            //other card
            self.otherCard.buddyLabel.text = "Buddies: \(dive.diveBuddy)"
            self.otherCard.centerLabel.text = "Dive Center: \(dive.diveCenter)"
            self.otherCard.noteLabel.text = "Notes: \(dive.note)"
        }
    }
    
}
