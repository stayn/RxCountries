//
//  CountryTableViewCell.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/20/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(with country: CountryList) {
        countryNameLabel.text = country.name
        populationLabel.text = "Population: \(country.population)"
    }

}
