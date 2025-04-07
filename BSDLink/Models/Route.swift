
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
    static let all: [Route] = [
        Route(
            id: "route_1",
            name: "Intermoda - Sektor 1.3 - Intermoda",
            routeNumber: 1,
            busStops: [
                "intermoda"
                ,
                "intermoda"
            ],
            bus: ["bus_a001", "bus_a002"],
            schedule: ["r1_1"],
            note: [
                "TIME TABLE SEWAKTU - WAKTU DAPAT BERUBAH MENYESUAIKAN KONDISI OPERASIONAL DAN TRAFFIC",
                "JADWAL BERWARNA KUNING HANYA BERLAKU, SABTU, MINGGU DAN HARI LIBUR BERLAKU",
                "THE BREEZE BERHENTI DAN MENUNGGU 1 MENIT ATAU MENYESUAIKAN DENGAN JADWAL",
                "ICE 6 BERHENTI DAN MENUNGGU 1 MENIT ATAU MENYESUAIKAN DENGAN JADWAL"
            ]
        )
    ]
}
