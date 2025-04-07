//
//  Bus.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import Foundation

struct Bus: Identifiable, Codable {
    let id: String
    let code: String
    let platNumber: String
    let operationalHour: String
    var isElectric: Bool = false
}

extension Bus {
    static func getBus(by id: String) -> Bus {
        return all.first(where: { $0.id == id }) ?? Bus(id: "000", code: "000", platNumber: "xx xxxx xx", operationalHour: "00.00 - 00.00")
    }
    
    static func getBusses(by ids: [String]) -> [Bus] {
        var buses : [Bus] = []
        
        for id in ids {
            buses += all.filter { $0.id == id}
        }
            
        return buses
    }
    
    static let all: [Bus] = [
        Bus(
            id: "bus_a001",
            code: "A001",
            platNumber: "B 1234 CDE",
            operationalHour: "07.00 - 17.00",
            isElectric: true
        ),
        Bus(
            id: "bus_a002",
            code: "A002",
            platNumber: "B 1234 ABC",
            operationalHour: "07.00 - 17.00"
        ),
    ]
}
