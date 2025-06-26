//
//  Country.swift
//  EUCountriesApp
//
//  Created by Ramesh Pandey on 26.6.2025.
//

import Foundation

struct Country: Decodable, Identifiable, Hashable {
    var id: String { cca2 }

    let cca2: String
    let name: Name
    let capital: [String]?
    let area: Double
    let population: Int
    let flags: Flags
    let currencies: [String: Currency]?
    let languages: [String: String]?
    let maps: Maps?

    struct Name: Decodable, Hashable {
        let common: String
        let official: String
    }

    struct Flags: Decodable, Hashable {
        let png: String?
        let svg: String?
        let alt: String?
    }

    struct Currency: Decodable, Hashable {
        let name: String?
        let symbol: String?
    }
    
    struct Maps: Decodable, Hashable {
            let googleMaps: String?
        }
}
