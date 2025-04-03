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
    var isElectric: Bool = false
}

extension Bus {
    static let all: [Bus] = [
        Bus(code: "A001", platNumber: "B1234ABC", operationalHour: "07.00 - 17.00", isElectric: true),
        Bus(code: "A001", platNumber: "B1234ABC", operationalHour: "07.00 - 17.00"),
        Bus(code: "A001", platNumber: "B1234ABC", operationalHour: "07.00 - 17.00")
    ]
}
