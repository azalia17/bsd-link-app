//
//  Schedule.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 27/03/25.
//
import Foundation

struct Schedule: Identifiable, Codable {
    let id: String
    let idx: Int // if there is only one schedule bakalan 1 terus. based on pdf
    let bus: String
    let scheduleDetail: [String]
}

struct ScheduleDetail: Identifiable, Codable {
    let id: String
    let index: Int // bus stops index, urutan keberapa
    let busStop: String
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
    
    
    
    static func getScheduleBusStopBasedWithTime(
        route: Route,
        busStopId: String,
        index: Int,
        fromHour: Int,
        fromMinute: Int
    ) -> [ScheduleTime] {
        let startTime = timeFrom(fromHour, fromMinute)
        let endTime = timeFrom(fromHour + 20, fromMinute)

        let matchingSchedules = Schedule.all.filter { route.schedule.contains($0.id) }

        let allDetailIDs = matchingSchedules.flatMap { $0.scheduleDetail }

        let allScheduleDetails = ScheduleDetail.getManyScheduleDetails(by: allDetailIDs)

        let matchingDetails =
        allScheduleDetails.filter { $0.busStop == busStopId && $0.index == index }

        let filteredTimes = matchingDetails.flatMap { detail in
            detail.time.filter { $0.time >= startTime && $0.time < endTime }
        }

        return filteredTimes.sorted { $0.time < $1.time }
    }
    
    static let all: [Schedule] = [
        Schedule(
            id: "r1_1",
            idx: 1,
            bus: "bus_a001",
            scheduleDetail: [
                "sd_r1_b1_intermoda1",
                "sd_r1_b1_intermoda3",
                "sd_r1_b1_intermoda14"
            ]
        ),
        Schedule(
            id: "r1_2",
            idx: 2,
            bus: "bus_a002",
            scheduleDetail: [
                "sd_r1_b2_intermoda1"
            ]
        ),
    ]
}

extension ScheduleDetail {
    static func getScheduleDetail(by id: String) -> ScheduleDetail {
        return all.first(where: {$0.id == id}) ?? ScheduleDetail(id: "", index: 0, busStop: "", time: [])
    }
    
    static func getManyScheduleDetails(by ids: [String]) -> [ScheduleDetail] {
        var schedules : [ScheduleDetail] = []
        
        for id in ids {
            schedules += all.filter { $0.id == id }
        }
        
        return schedules
    }
    
    static func getScheduleTime(schedule: [String], index: Int, busStopId: String) -> [ScheduleTime] {
        
        return getManyScheduleDetails(by: schedule).filter { $0.index == index && $0.busStop == busStopId }.first?.time ?? [ScheduleTime(time: timeFrom(0, 0))]
    }
    
    static let all: [ScheduleDetail] = [
        ScheduleDetail(
            id: "sd_r1_b1_intermoda1",
            index: 1,
            busStop: "intermoda",
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
            id: "sd_r1_b1_intermoda3",
            index: 3,
            busStop: "intermoda",
            time: [
                ScheduleTime(time: timeFrom(6, 03)),
                ScheduleTime(time: timeFrom(8, 03)),
                ScheduleTime(time: timeFrom(10, 03)),
                ScheduleTime(time: timeFrom(12, 03)),
                ScheduleTime(time: timeFrom(14, 03)),
                ScheduleTime(time: timeFrom(16, 03)),
                ScheduleTime(time: timeFrom(18, 03)),
            ]
        ),
        ScheduleDetail(
            id: "sd_r1_b1_intermoda14",
            index: 14,
            busStop: "intermoda",
            time: [
                ScheduleTime(time: timeFrom(6, 09)),
                ScheduleTime(time: timeFrom(8, 19)),
                ScheduleTime(time: timeFrom(10, 29)),
                ScheduleTime(time: timeFrom(12, 39)),
                ScheduleTime(time: timeFrom(14, 49)),
                ScheduleTime(time: timeFrom(16, 59)),
                ScheduleTime(time: timeFrom(18, 49)),
            ]
        ),
        ScheduleDetail(
            id: "sd_r1_b2_intermoda1",
            index: 1,
            busStop: "intermoda",
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

//func getHourAndMinute(_ hour: Int, _ minute: Int) -> String {
//    let date = timeFrom(hour, minute)
//    
//    let formatter = DateFormatter()
//        formatter.dateFormat = "HH:mm"
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        return formatter.string(from: date)
//}
