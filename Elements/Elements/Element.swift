//
//  Elements.swift
//  Elements
//
//  Created by Christian Hurtado on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    var number: Int
    let symbol: String
    let source: String
    let atomic_mass: Double
    let melt: Double
    let boil: Double
    let discovered_by: String
    let id: String?
    
}
