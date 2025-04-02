//
//  Bus.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import Foundation

struct Bus: Identifiable {
    let id = UUID()
    let code: String
    let platNumber: String
    let operationalHour: String
    let isElectric: Bool = false
}
