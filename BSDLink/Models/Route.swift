
import Foundation
import MapKit

struct Route: Identifiable, Codable {
    let id: String
    let name: String
    let routeNumber: Int
    let busStops: [String]
    let bus: [String]
    let schedule: [String]
    let note: [String]
}

extension Route {
//    static.le

}
