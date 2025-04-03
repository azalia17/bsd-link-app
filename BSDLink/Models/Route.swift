
import Foundation
import MapKit

struct Route: Identifiable {
    let id = UUID()
    let name: String
    let routeNumber: String
    let busStops: [BusStop]
    let bus: [Bus]
}

var sampleRoutes: [Route] = [
    Route(name: "Route 1 (Intermoda - Halte Sektor 1.3)", routeNumber: "Route 1", busStops: [
        BusStop(name: "Intermoda",
                coordinates: .intermoda,
                schedule: [
                    
                ],
                images: ["Intermoda_1", "Intermoda_2"],
                isBigHalte: true, routes: []
                ),
        
        BusStop(name: "Cosmo",
                coordinates: .cosmo,
                schedule: [
                    
                ],
                images: ["Cosmo_1"],
                isBigHalte: true, routes: []
                ),
        
        BusStop(name: "Verdant View",
                coordinates: .verdantView,
                schedule: [
                    
                ],
                images: ["Verdant View_1"],
                isBigHalte: true, routes: []
                )
    ],
          bus: []),
    
    Route(name: "Route 2 (Halte Sektor 1.3 - Intermoda)", routeNumber: "Route 2", busStops: [
        BusStop(name: "Halte Sektor 1.3",
                coordinates: .sektor13,
                schedule: [
                    
                ],
                images: ["Placeholder"],
                isBigHalte: true, routes: []),
        
        BusStop(name: "Griya Loka 2",
                coordinates: .griyaLoka2,
                schedule: [
                    
                ],
                images: ["Griya Loka 2_1"],
                isBigHalte: false, routes: []),
        
        
        BusStop(name: "Santa Ursula 1",
                coordinates: .santaUrsula1,
                schedule: [
                    
                ],
                images: ["Santa Ursula 1_1"],
                isBigHalte: true, routes: [])
    ],
          bus: []),
    
    
]
