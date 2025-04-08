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
                "sd_r1_b1_intermoda_1",
                "sd_r1_b1_cosmo_2",
                "sd_r1_b1_verdantView_3",
                "sd_r1_b1_eternity_4",
                "sd_r1_b1_simplicity2_5",
                "sd_r1_b1_edutown1_6",
                "sd_r1_b1_edutown2_7",
                "sd_r1_b1_ice1_8",
                "sd_r1_b1_ice2_9",
                "sd_r1_b1_ice6_10",
                "sd_r1_b1_ice5_11",
                "sd_r1_b1_gop1_12",
                "sd_r1_b1_smlPlaza_13",
                "sd_r1_b1_theBreeze_14",
                "sd_r1_b1_cbdTimur1_15",
                "sd_r1_b1_cbdTimur2_16",
                "sd_r1_b1_navapark1_17",
                "sd_r1_b1_swa2_18",
                "sd_r1_b1_giant_19",
                "sd_r1_b1_ekaHospital1_20",
                "sd_r1_b1_puspitaLoka_21",
                "sd_r1_b1_polsekSerpong_22",
                "sd_r1_b1_rukoMadrid_23",
                "sd_r1_b1_pasmodTimur_24",
                "sd_r1_b1_griyaloka1_25",
                "sd_r1_b1_halteSektor13_26",
                "sd_r1_b1_halteSektor13_27",
                "sd_r1_b1_griyaloka2_28",
                "sd_r1_b1_santaUrsula1_29",
                "sd_r1_b1_santaUrsula2_30",
                "sd_r1_b1_sentraOnderdil_31",
                "sd_r1_b1_autoparts_32",
                "sd_r1_b1_ekaHospital2_33",
                "sd_r1_b1_eastBusinessDistrict_34",
                "sd_r1_b1_swa1_35",
                "sd_r1_b1_greenCove_36",
                "sd_r1_b1_theBreeze_37",
                "sd_r1_b1_cbdTimur1_38",
                "sd_r1_b1_aeonMall11_39",
                "sd_r1_b1_cbdBarat2_40",
                "sd_r1_b1_simplicity_41",
                "sd_r1_b1_cosmo_42",
                "sd_r1_b1_verdantView_43",
                "sd_r1_b1_eternity_44",
                "sd_r1_b1_terminalIntermoda_45",
                "sd_r1_b1_iconBusinessPark_46",
                "sd_r1_b1_masjidAlUkhuwah_47",
                "sd_r1_b1_divenaDeshna_48",
                "sd_r1_b1_theAvaniClubHouse_49",
                "sd_r1_b1_ammarilla_50",
                "sd_r1_b1_chadnya_51",
                "sd_r1_b1_atmajaya_52",
                "sd_r1_b1_intermoda_53"
            ]
        ),
        Schedule(
            id: "r1_2",
            idx: 2,
            bus: "bus_a002",
            scheduleDetail: [
                "sd_r1_b2_intermoda_1",
                "sd_r1_b2_cosmo_2",
                "sd_r1_b2_verdantView_3",
                "sd_r1_b2_eternity_4",
                "sd_r1_b2_simplicity2_5",
                "sd_r1_b2_edutown1_6",
                "sd_r1_b2_edutown2_7",
                "sd_r1_b2_ice1_8",
                "sd_r1_b2_ice2_9",
                "sd_r1_b2_ice6_10",
                "sd_r1_b2_ice5_11",
                "sd_r1_b2_gop1_12",
                "sd_r1_b2_smlPlaza_13",
                "sd_r1_b2_theBreeze_14",
                "sd_r1_b2_cbdTimur1_15",
                "sd_r1_b2_cbdTimur2_16",
                "sd_r1_b2_navapark1_17",
                "sd_r1_b2_swa2_18",
                "sd_r1_b2_giant_19",
                "sd_r1_b2_ekaHospital1_20",
                "sd_r1_b2_puspitaLoka_21",
                "sd_r1_b2_polsekSerpong_22",
                "sd_r1_b2_rukoMadrid_23",
                "sd_r1_b2_pasmodTimur_24",
                "sd_r1_b2_griyaloka1_25",
                "sd_r1_b2_halteSektor13_26",
                "sd_r1_b2_halteSektor13_27",
                "sd_r1_b2_griyaloka2_28",
                "sd_r1_b2_santaUrsula1_29",
                "sd_r1_b2_santaUrsula2_30",
                "sd_r1_b2_sentraOnderdil_31",
                "sd_r1_b2_autoparts_32",
                "sd_r1_b2_ekaHospital2_33",
                "sd_r1_b2_eastBusinessDistrict_34",
                "sd_r1_b2_swa1_35",
                "sd_r1_b2_greenCove_36",
                "sd_r1_b2_theBreeze_37",
                "sd_r1_b2_cbdTimur1_38",
                "sd_r1_b2_aeonMall11_39",
                "sd_r1_b2_cbdBarat2_40",
                "sd_r1_b2_simplicity_41",
                "sd_r1_b2_cosmo_42",
                "sd_r1_b2_verdantView_43",
                "sd_r1_b2_eternity_44",
                "sd_r1_b2_terminalIntermoda_45",
                "sd_r1_b2_iconBusinessPark_46",
                "sd_r1_b2_masjidAlUkhuwah_47",
                "sd_r1_b2_divenaDeshna_48",
                "sd_r1_b2_theAvaniClubHouse_49",
                "sd_r1_b2_ammarilla_50",
                "sd_r1_b2_chadnya_51",
                "sd_r1_b2_atmajaya_52",
                "sd_r1_b2_intermoda_53"
            ]
        ),
        Schedule(
            id: "r2_1",
            idx: 2,
            bus: "bus_a002",
            scheduleDetail: [
            ]
        )
    ]
}

// Custom decoding for time to handle missing 'isRegular' in JSON
struct TimeDecoder: Codable {
    let hour: Int
    let minute: Int
    let isRegular: Bool?

    // Computed property for date
    var date: Date {
        let calendar = Calendar.current
        let date = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        return date
    }

    // Custom initializer for 'isRegular' to default to true if missing
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hour = try container.decode(Int.self, forKey: .hour)
        minute = try container.decode(Int.self, forKey: .minute)
        isRegular = try container.decodeIfPresent(Bool.self, forKey: .isRegular) ?? true
    }

    private enum CodingKeys: String, CodingKey {
        case hour, minute, isRegular
    }
}

extension ScheduleDetail {
    // Custom decoding to handle the 'time' array
        private enum CodingKeys: String, CodingKey {
            case id, index, busStop = "BusStop", time
        }

        // Custom initializer for decoding 'time' and handling 'isRegular' default
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey: .id)
            index = try container.decode(Int.self, forKey: .index)
            busStop = try container.decode(String.self, forKey: .busStop)
            
            // Decode time and map to ScheduleTime
            let timeArray = try container.decode([TimeDecoder].self, forKey: .time)
            time = timeArray.map { ScheduleTime(time: $0.date, isRegular: $0.isRegular ?? true) }
        }
    
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
    
    static let all: [ScheduleDetail] = load("scheduleDetail.json")
    
}

func timeFrom(_ hour: Int, _ minute: Int) -> Date {
    return Calendar.current.date(from: DateComponents(hour: hour, minute: minute))!
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
