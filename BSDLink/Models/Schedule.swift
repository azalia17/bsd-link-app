//
//  Schedule.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 27/03/25.
//
import Foundation

struct Schedule: Identifiable, Codable {
    let id: String
    let idx: Int
    let bus: String
    let scheduleDetail: [String]
}

struct ScheduleDetail: Identifiable, Codable {
    let id: String
    let index: Int
    let BusStop: String
    let time: [ScheduleTime]
}

struct ScheduleTime: Identifiable, Codable {
    var id = UUID()
    let time: Date
    var isRegular: Bool = true
}

extension Schedule {
    static func getSchedules(by ids: [String]) -> [Schedule] {
        var schedules : [Schedule] = []
        
        for id in ids {
            schedules += all.filter { $0.id == id}
        }
        
        return schedules
    }
    
    static func getScheduleBusStopBased(busStopId: String, idx: Int, fromHour: Int, fromMinute: Int) -> [ScheduleTime] {
        
        let filteredDetails = ScheduleDetail.all.filter {
            $0.BusStop == busStopId && $0.index == idx
        }
        
        let startTime = timeFrom(fromHour, fromMinute)
        let endTime = timeFrom(fromHour + 1, fromMinute)
        
        let filteredTimes = filteredDetails.flatMap { detail in
            detail.time.filter { $0.time >= startTime && $0.time < endTime }
        }
        
        return filteredTimes
    }
    
    
    static let all: [Schedule] = [
        Schedule(
            id: "r1_1",
            idx: 1,
            bus: "bus_a001",
            scheduleDetail: [
                "sd_r1_b1_intermoda"
            ]
        )
    ]
}

extension ScheduleDetail {
    static func getScheduleDetail(by id: String) -> ScheduleDetail {
        return all.first(where: {$0.id == id}) ?? ScheduleDetail(id: "", index: 0, BusStop: "", time: [])
    }
    
    static let all: [ScheduleDetail] = [
        ScheduleDetail(
            id: "sd_r1_b1_intermoda",
            index: 1,
            BusStop: "intermoda",
            time: [
                ScheduleTime(time: timeFrom(6, 00)),
                ScheduleTime(time: timeFrom(8, 10)),
                ScheduleTime(time: timeFrom(10, 25)),
                ScheduleTime(time: timeFrom(12, 35)),
                ScheduleTime(time: timeFrom(14, 45)),
                ScheduleTime(time: timeFrom(16, 50)),
                ScheduleTime(time: timeFrom(18, 45)),
            ]
        ),
        ScheduleDetail(
            id: "sd_r1_b2_intermoda",
            index: 14,
            BusStop: "intermoda",
            time: [
                ScheduleTime(time: timeFrom(6, 30)),
                ScheduleTime(time: timeFrom(8, 50)),
                ScheduleTime(time: timeFrom(10, 55)),
                ScheduleTime(time: timeFrom(13, 05)),
                ScheduleTime(time: timeFrom(15, 15)),
                ScheduleTime(time: timeFrom(17, 20), isRegular: false),
                ScheduleTime(time: timeFrom(19, 25)),
            ]
        ),
    ]
}

func timeFrom(_ hour: Int, _ minute: Int) -> Date {
    return Calendar.current.date(from: DateComponents(hour: hour, minute: minute))!
}
