import Foundation
import MapKit

struct BusStop: Identifiable{
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
    let bigHalte: Bool
    let schedule: [Schedule]
    let images: [String]
    let isBigHalte: Bool
    let routes: [Route]
}
