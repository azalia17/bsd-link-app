import Foundation
import MapKit

struct BusStop: Identifiable {
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
    let schedule: [Schedule]
    let images: [String]
    var isBigHalte: Bool = false
    let routes: [Route]
}

extension BusStop {
    static let all: [BusStop] = [
        BusStop(name: "The Breeze", coordinates: .theBreeze, schedule: [Schedule(index: 1, bus: Bus(code: "D23", platNumber: "B 2343 XXX", operationalHour: "09.00 - 17.00"), scheduleDetail: [])], images: [], isBigHalte: false, routes: [])
    ]
}
