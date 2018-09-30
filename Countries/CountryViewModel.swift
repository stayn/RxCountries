//
//  CountryViewModel.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/30/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation

class CountryViewModel {
    var details: String
    
    init() {
        self.details = ""
    }
    
    init(country: Country) {
        var details = ""
        details.append("Capital: ")
        details.append("\(country.capital)\n")
        details.append("Population: ")
        details.append("\(country.population)\n")
        
        details.append("Borders: ")
        country.borders.forEach { border in
            details.append(contentsOf: "\(border), ")
        }
        
        details = String(details.dropLast(2))
        
        details.append("\nCurrencies: ")
        country.currencies.forEach({
            details.append("\($0.name) with code \($0.code)\n")
        })
        
        self.details = details
    }
}
