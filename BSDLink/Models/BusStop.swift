import Foundation
import MapKit

struct BusStop: Identifiable{
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
    let schedule: [Schedule]
    let images: [String]
    let isBigHalte: Bool
}
