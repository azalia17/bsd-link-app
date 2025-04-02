
import Foundation
import MapKit

struct Route: Identifiable {
    let id = UUID()
    let name: String
    let busStops: [BusStop]
    let bus: [Bus]
}

var sampleRoutes: [Route] = [
    Route(name: "Route 1", busStops: [
        BusStop(name: "Intermoda",
                coordinates: .intermoda,
                schedule: [
                    
                ],
                images: ["Intermoda_1", "Intermoda_2"],
                isBigHalte: true,
                routes: []),
        
        BusStop(name: "Cosmo",
                coordinates: .cosmo,
                schedule: [
                    
                ],
                images: ["Cosmo_1"],
                isBigHalte: true,
                routes: []),
        
        BusStop(name: "Verdant View",
                coordinates: .verdantView,
                schedule: [
                    
                ],
                images: ["Verdant View_1"],
                isBigHalte: true,
                routes: [])
    ], bus: [])
]
