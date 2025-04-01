//
//  Schedule.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 27/03/25.
//
import Foundation

struct Schedule: Identifiable, Hashable {
    let id = UUID()
    let time: Date
    let isRegular: Bool
}

extension Schedule {
    static let all: [Schedule] = [
        Schedule(time: Date.now, isRegular: true),
        Schedule(time: Date.now, isRegular: false),
        Schedule(time: Date.now, isRegular: true),
        Schedule(time: Date.now, isRegular: true),
        Schedule(time: Date.now, isRegular: true),
        Schedule(time: Date.now, isRegular: false),
    ]
}
