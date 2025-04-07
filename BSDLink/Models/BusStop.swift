import Foundation
import MapKit

struct BusStop: Identifiable, Codable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
//    let schedule: [Schedule]
    let images: [String]
    let routes: [String]
    //    let id: String
    //    let name: String
    //    let coordinates: CLLocationCoordinate2D
    //    //    let schedule: [String]
    //    let images: [String]
    //    let routes: [String]
    //    var isBigHalte: Bool = false
}




extension BusStop {
    static func getSingleStop(by id: String) -> BusStop {
        return all.first(where: {$0.id == id}) ?? BusStop(id: "", name: "xx", latitude: 0.0, longitude: 0.0, images: [], routes: [])
    }
    
    static func getStops(by ids: [String]) -> [BusStop] {
        var stops : [BusStop] = []
        
        for id in ids {
            stops += all.filter { $0.id == id}
        }
            
        return stops
    }
    
    
    static let all: [BusStop] = [
        BusStop(id: "intermoda", name: "Intermoda", latitude: CLLocationCoordinate2D.intermoda.latitude, longitude: CLLocationCoordinate2D.intermoda.longitude, images: ["Intermoda_1", "Intermoda_2"], routes: ["route_1"])
    ]
    
    
    //            static let all: [BusStop] = [
    //                BusStop(
    //                    id: "bs_aeon_mall_1",
    //                    name: "AEON Mall 1",
    //                    coordinates: .aeonMall1,
    //                    images: [],
    //                    routes: ["route_1"]
    //                ),
    //                BusStop(
    //                    id: "intermoda",
    //                    name: "Intermoda",
    //                    coordinates: .aeonMall1,
    //                    images: ["Intermoda_1", "Intermoda_2"],
    //                    routes: ["route_1"]
    //                ),
    //            ]
    //    static func getSingleStop(by id: String) -> BusStop {
    //        return all.first(where: {$0.id == id} ?? BusStop(id: "xx", name: "xx", coordinates: CLLocationCoordinate2D(), images: [], routes: [))
    //            }
    //
    //            static func getStops(by ids: [String]) -> [BusStop] {
    //            return all.filter { $0.id ==  }
    //        }
}
