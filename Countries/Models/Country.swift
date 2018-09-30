//
//  Country.swift
//  Countries
//
//  Created by Anastasia Loginova on 9/20/18.
//  Copyright © 2018 loginova. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let population: Int
    let capital: String
    let borders: [String]
    let currencies: [Currency]
    
    init(with name: String) {
        self.name = name
        self.capital = ""
        self.population = 0
        self.borders = []
        self.currencies = []
    }
}
