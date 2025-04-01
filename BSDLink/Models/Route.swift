
import Foundation
import MapKit

struct Route: Identifiable{
    let id = UUID()
    let name: String
    let busStops: [BusStop]
    
}

var sampleRoutes: [Route] = [
    Route(name: "Route 1", busStops: [
        BusStop(name: "Intermoda",
                coordinates: .intermoda,
                bigHalte: true,
                schedule: [
                    
                ],
                images: ["Intermoda_1", "Intermoda_2"],
                isBigHalte: true,
                routes: []),
        
        BusStop(name: "Cosmo",
                coordinates: .cosmo,
                bigHalte: true,
                schedule: [
                    
                ],
                images: ["Cosmo_1"],
                isBigHalte: true,
                routes: []),
        
        BusStop(name: "Verdant View",
                coordinates: .verdantView,
                bigHalte: true,
                schedule: [
                    
                ],
                images: ["Verdant View_1"],
                isBigHalte: true,
                routes: [])
    ])
    
]
