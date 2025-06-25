//
//  Item.swift
//  EUCountriesApp
//
//  Created by Ramesh Pandey on 26.6.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
