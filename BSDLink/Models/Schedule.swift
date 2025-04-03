//
//  Schedule.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 27/03/25.
//
import Foundation

struct Schedule: Identifiable {
    let id = UUID()
    let index: Int
    let bus: Bus
    let scheduleDetail: [ScheduleDetail]
}

struct ScheduleDetail: Identifiable{
    let id = UUID()
    let BusStop: BusStop
    let time: [ScheduleTime]
}

struct ScheduleTime: Identifiable {
    let id = UUID()
    let time: Date
    let isRegular: Bool
}

extension ScheduleTime {
    static let all: [ScheduleTime] = [
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: false),
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: true),
        
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: false),
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: true),
        
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: false),
        ScheduleTime(time: Date.now, isRegular: true),
        ScheduleTime(time: Date.now, isRegular: true),
        
    ]
}
