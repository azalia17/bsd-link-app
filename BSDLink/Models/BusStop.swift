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
             BusStop(id: "intermoda", name: "Intermoda", latitude: CLLocationCoordinate2D.intermoda.latitude, longitude: CLLocationCoordinate2D.intermoda.longitude, images: ["Intermoda_1", "Intermoda_2"], routes: ["route_1"]),
             BusStop(id: "bs_aeon_mall_1", name: "Aeon Mall 1", latitude: CLLocationCoordinate2D.intermoda.latitude, longitude: CLLocationCoordinate2D.intermoda.longitude, images: ["Intermoda_1", "Intermoda_2"], routes: ["route_1"]),
         ]
    
    
//    static let all: [BusStop] = [
//        
//        BusStop(
//            id: "aeonMall1",
//            name: "AeonMall1",
//            latitude: CLLocationCoordinate2D.aeonMall1.latitude,
//            longitude: CLLocationCoordinate2D.aeonMall1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_4", "route_7"]
//        ),
//        BusStop(
//            id: "aeonMall2",
//            name: "AeonMall2",
//            latitude: CLLocationCoordinate2D.aeonMall2.latitude,
//            longitude: CLLocationCoordinate2D.aeonMall2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_5", "route_7"]
//        ),
//        BusStop(
//            id: "albera",
//            name: "Albera",
//            latitude: CLLocationCoordinate2D.albera.latitude,
//            longitude: CLLocationCoordinate2D.albera.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//        BusStop(
//            id: "allevare",
//            name: "Allevare",
//            latitude: CLLocationCoordinate2D.allevare.latitude,
//            longitude: CLLocationCoordinate2D.allevare.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//        BusStop(
//            id: "amarilla",
//            name: "Amarilla",
//            latitude: CLLocationCoordinate2D.amarilla.latitude,
//            longitude: CLLocationCoordinate2D.amarilla.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//        BusStop(
//            id: "astra",
//            name: "Astra",
//            latitude: CLLocationCoordinate2D.astra.latitude,
//            longitude: CLLocationCoordinate2D.astra.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3", "route_7"]
//        ),
//        BusStop(
//            id: "atmajaya",
//            name: "Atmajaya",
//            latitude: CLLocationCoordinate2D.atmajaya.latitude,
//            longitude: CLLocationCoordinate2D.atmajaya.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//        BusStop(
//            id: "autoparts",
//            name: "Autoparts",
//            latitude: CLLocationCoordinate2D.autoparts.latitude,
//            longitude: CLLocationCoordinate2D.autoparts.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//        BusStop(
//            id: "avani",
//            name: "Avani",
//            latitude: CLLocationCoordinate2D.avani.latitude,
//            longitude: CLLocationCoordinate2D.avani.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//        
//        BusStop(
//            id: "bmcDigitalHub1",
//            name: "BMC",
//            latitude: CLLocationCoordinate2D.bmcDigitalHub1.latitude,
//            longitude: CLLocationCoordinate2D.bmcDigitalHub1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3", "route_7"]
//        ),
//        
//        
//        BusStop(
//            id: "bca",
//            name: "Bca",
//            latitude: CLLocationCoordinate2D.bca.latitude,
//            longitude: CLLocationCoordinate2D.bca.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "casaDeParco1",
//            name: "CasaDeParco1",
//            latitude: CLLocationCoordinate2D.casaDeParco1.latitude,
//            longitude: CLLocationCoordinate2D.casaDeParco1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "casaDeParco2",
//            name: "CasaDeParco2",
//            latitude: CLLocationCoordinate2D.casaDeParco2.latitude,
//            longitude: CLLocationCoordinate2D.casaDeParco2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "cbdBarat1",
//            name: "CbdBarat1",
//            latitude: CLLocationCoordinate2D.cbdBarat1.latitude,
//            longitude: CLLocationCoordinate2D.cbdBarat1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_5", "route_6"]
//        ),
//
//        BusStop(
//            id: "cbdBarat2",
//            name: "CbdBarat2",
//            latitude: CLLocationCoordinate2D.cbdBarat2.latitude,
//            longitude: CLLocationCoordinate2D.cbdBarat2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_4", "route_5", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "cbdSelatan1",
//            name: "CbdSelatan1",
//            latitude: CLLocationCoordinate2D.cbdSelatan1.latitude,
//            longitude: CLLocationCoordinate2D.cbdSelatan1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_4", "route_5", "route_7"]
//        ),
//
//        BusStop(
//            id: "cbdTimur1",
//            name: "CbdTimur1",
//            latitude: CLLocationCoordinate2D.cbdTimur1.latitude,
//            longitude: CLLocationCoordinate2D.cbdTimur1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_4", "route_5", "route_7"]
//        ),
//
//        BusStop(
//            id: "cbdTimurGop2",
//            name: "CBDTimur2",
//            latitude: CLLocationCoordinate2D.cbdTimurGop2.latitude,
//            longitude: CLLocationCoordinate2D.cbdTimurGop2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_4", "route_5"]
//        ),
//
//        BusStop(
//            id: "cbdUtara3",
//            name: "CbdUtara3",
//            latitude: CLLocationCoordinate2D.cbdUtara3.latitude,
//            longitude: CLLocationCoordinate2D.cbdUtara3.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_5"]
//        ),
//
//        BusStop(
//            id: "chadnya",
//            name: "Chadnya",
//            latitude: CLLocationCoordinate2D.chadnya.latitude,
//            longitude: CLLocationCoordinate2D.chadnya.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//
//        BusStop(
//            id: "collinare",
//            name: "Collinare",
//            latitude: CLLocationCoordinate2D.collinare.latitude,
//            longitude: CLLocationCoordinate2D.collinare.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "cosmo",
//            name: "Cosmo",
//            latitude: CLLocationCoordinate2D.cosmo.latitude,
//            longitude: CLLocationCoordinate2D.cosmo.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//
//        BusStop(
//            id: "courtsMegaStore",
//            name: "CourtsMegaStore",
//            latitude: CLLocationCoordinate2D.courtsMegaStore.latitude,
//            longitude: CLLocationCoordinate2D.courtsMegaStore.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "deBrassia",
//            name: "DeBrassia",
//            latitude: CLLocationCoordinate2D.deBrassia.latitude,
//            longitude: CLLocationCoordinate2D.deBrassia.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "deFrangpani",
//            name: "DeFrangpani",
//            latitude: CLLocationCoordinate2D.deFrangpani.latitude,
//            longitude: CLLocationCoordinate2D.deFrangpani.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "deHeliconia1",
//            name: "DeHeliconia1",
//            latitude: CLLocationCoordinate2D.deHeliconia1.latitude,
//            longitude: CLLocationCoordinate2D.deHeliconia1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "deHeliconia2",
//            name: "DeHeliconia2",
//            latitude: CLLocationCoordinate2D.deHeliconia2.latitude,
//            longitude: CLLocationCoordinate2D.deHeliconia2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "deMaja",
//            name: "DeMaja",
//            latitude: CLLocationCoordinate2D.deMaja.latitude,
//            longitude: CLLocationCoordinate2D.deMaja.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "deNara",
//            name: "DeNara",
//            latitude: CLLocationCoordinate2D.deNara.latitude,
//            longitude: CLLocationCoordinate2D.deNara.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//        
//        BusStop(
//            id: "dePark1",
//            name: "DePark1",
//            latitude: CLLocationCoordinate2D.dePark1.latitude,
//            longitude: CLLocationCoordinate2D.dePark1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "dePark2",
//            name: "DePark2",
//            latitude: CLLocationCoordinate2D.dePark2.latitude,
//            longitude: CLLocationCoordinate2D.dePark2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "digitalHub1",
//            name: "DigitalHub1",
//            latitude: CLLocationCoordinate2D.digitalHub1.latitude,
//            longitude: CLLocationCoordinate2D.digitalHub1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "digitalHub2",
//            name: "DigitalHub2",
//            latitude: CLLocationCoordinate2D.digitalHub2.latitude,
//            longitude: CLLocationCoordinate2D.digitalHub2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3"]
//        ),
//
//        BusStop(
//            id: "divenaDeshna",
//            name: "Divena&Deshna",
//            latitude: CLLocationCoordinate2D.divenaDeshna.latitude,
//            longitude: CLLocationCoordinate2D.divenaDeshna.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//
//        BusStop(
//            id: "eastBusinessDistrict",
//            name: "EastBusinessDistrict",
//            latitude: CLLocationCoordinate2D.eastBusinessDistrict.latitude,
//            longitude: CLLocationCoordinate2D.eastBusinessDistrict.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "edutown1",
//            name: "Edutown1",
//            latitude: CLLocationCoordinate2D.edutown1.latitude,
//            longitude: CLLocationCoordinate2D.edutown1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "edutown2",
//            name: "Edutown2",
//            latitude: CLLocationCoordinate2D.edutown2.latitude,
//            longitude: CLLocationCoordinate2D.edutown2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "ekaHospital1",
//            name: "EkaHospital1",
//            latitude: CLLocationCoordinate2D.ekaHospital1.latitude,
//            longitude: CLLocationCoordinate2D.ekaHospital1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "ekaHospital2",
//            name: "EkaHospital2",
//            latitude: CLLocationCoordinate2D.ekaHospital2.latitude,
//            longitude: CLLocationCoordinate2D.ekaHospital2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "epicon",
//            name: "Epicon",
//            latitude: CLLocationCoordinate2D.epicon.latitude,
//            longitude: CLLocationCoordinate2D.epicon.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "eternity",
//            name: "Eternity",
//            latitude: CLLocationCoordinate2D.eternity.latitude,
//            longitude: CLLocationCoordinate2D.eternity.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3"]
//        ),
//
//        BusStop(
//            id: "extremePark",
//            name: "ExtremePark",
//            latitude: CLLocationCoordinate2D.extremePark.latitude,
//            longitude: CLLocationCoordinate2D.extremePark.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "fbl1",
//            name: "Fbl1",
//            latitude: CLLocationCoordinate2D.fbl1.latitude,
//            longitude: CLLocationCoordinate2D.fbl1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "fbl2",
//            name: "Fbl2",
//            latitude: CLLocationCoordinate2D.fbl2.latitude,
//            longitude: CLLocationCoordinate2D.fbl2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "fbl5",
//            name: "Fbl5",
//            latitude: CLLocationCoordinate2D.fbl5.latitude,
//            longitude: CLLocationCoordinate2D.fbl5.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2"]
//        ),
//
//        BusStop(
//            id: "fiore",
//            name: "Fiore",
//            latitude: CLLocationCoordinate2D.fiore.latitude,
//            longitude: CLLocationCoordinate2D.fiore.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "foglio",
//            name: "Foglio",
//            latitude: CLLocationCoordinate2D.foglio.latitude,
//            longitude: CLLocationCoordinate2D.foglio.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "foresta1",
//            name: "Foresta1",
//            latitude: CLLocationCoordinate2D.foresta1.latitude,
//            longitude: CLLocationCoordinate2D.foresta1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "foresta2",
//            name: "Foresta2",
//            latitude: CLLocationCoordinate2D.foresta2.latitude,
//            longitude: CLLocationCoordinate2D.foresta2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "fresco",
//            name: "Fresco",
//            latitude: CLLocationCoordinate2D.fresco.latitude,
//            longitude: CLLocationCoordinate2D.fresco.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "giantBSDCity1",
//            name: "GiantBSDCity1",
//            latitude: CLLocationCoordinate2D.giantBSDCity1.latitude,
//            longitude: CLLocationCoordinate2D.giantBSDCity1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "giardina",
//            name: "Giardina",
//            latitude: CLLocationCoordinate2D.giardina.latitude,
//            longitude: CLLocationCoordinate2D.giardina.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "gop1",
//            name: "Gop1",
//            latitude: CLLocationCoordinate2D.gop1.latitude,
//            longitude: CLLocationCoordinate2D.gop1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "gramedia",
//            name: "Gramedia",
//            latitude: CLLocationCoordinate2D.gramedia.latitude,
//            longitude: CLLocationCoordinate2D.gramedia.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "grandLucky1",
//            name: "GrandLucky1",
//            latitude: CLLocationCoordinate2D.grandLucky1.latitude,
//            longitude: CLLocationCoordinate2D.grandLucky1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "greencove",
//            name: "Greencove",
//            latitude: CLLocationCoordinate2D.greencove.latitude,
//            longitude: CLLocationCoordinate2D.greencove.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_5"]
//        ),
//
//        BusStop(
//            id: "greenwichPark1",
//            name: "GreenwichPark1",
//            latitude: CLLocationCoordinate2D.greenwichPark1.latitude,
//            longitude: CLLocationCoordinate2D.greenwichPark1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "greenwichPark2",
//            name: "GreenwichPark2",
//            latitude: CLLocationCoordinate2D.greenwichPark2.latitude,
//            longitude: CLLocationCoordinate2D.greenwichPark2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "greenwichParkOffice",
//            name: "GreenwichParkOffice",
//            latitude: CLLocationCoordinate2D.greenwichParkOffice.latitude,
//            longitude: CLLocationCoordinate2D.greenwichParkOffice.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2"]
//        ),
//
//        BusStop(
//            id: "griyaLoka1",
//            name: "GriyaLoka1",
//            latitude: CLLocationCoordinate2D.griyaLoka1.latitude,
//            longitude: CLLocationCoordinate2D.griyaLoka1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "griyaLoka2",
//            name: "GriyaLoka2",
//            latitude: CLLocationCoordinate2D.griyaLoka2.latitude,
//            longitude: CLLocationCoordinate2D.griyaLoka2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "horizonBroadway",
//            name: "HorizonBroadway",
//            latitude: CLLocationCoordinate2D.horizonBroadway.latitude,
//            longitude: CLLocationCoordinate2D.horizonBroadway.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "ice1",
//            name: "Ice1",
//            latitude: CLLocationCoordinate2D.ice1.latitude,
//            longitude: CLLocationCoordinate2D.ice1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_4", "route_5", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "ice2",
//            name: "Ice2",
//            latitude: CLLocationCoordinate2D.ice2.latitude,
//            longitude: CLLocationCoordinate2D.ice2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_4", "route_5", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "ice5",
//            name: "Ice5",
//            latitude: CLLocationCoordinate2D.ice5.latitude,
//            longitude: CLLocationCoordinate2D.ice5.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_4", "route_5", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "ice6",
//            name: "Ice6",
//            latitude: CLLocationCoordinate2D.ice6.latitude,
//            longitude: CLLocationCoordinate2D.ice6.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_4", "route_5", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "iceBusinessPark",
//            name: "IceBusinessPark",
//            latitude: CLLocationCoordinate2D.iceBusinessPark.latitude,
//            longitude: CLLocationCoordinate2D.iceBusinessPark.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_4", "route_5", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "iconBusinessPark",
//            name: "IconBusinessPark",
//            latitude: CLLocationCoordinate2D.iconBusinessPark.latitude,
//            longitude: CLLocationCoordinate2D.iconBusinessPark.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//
//        BusStop(
//            id: "iconCentro",
//            name: "IconCentro",
//            latitude: CLLocationCoordinate2D.iconCentro.latitude,
//            longitude: CLLocationCoordinate2D.iconCentro.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4"]
//        ),
//
//        BusStop(
//            id: "illustria",
//            name: "Illustria",
//            latitude: CLLocationCoordinate2D.illustria.latitude,
//            longitude: CLLocationCoordinate2D.illustria.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "intermoda",
//            name: "Intermoda",
//            latitude: CLLocationCoordinate2D.intermoda.latitude,
//            longitude: CLLocationCoordinate2D.intermoda.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_4", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "jadeite",
//            name: "Jadeite",
//            latitude: CLLocationCoordinate2D.jadeite.latitude,
//            longitude: CLLocationCoordinate2D.jadeite.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3", "route_4"]
//        ),
//
//        BusStop(
//            id: "lobbyAeon",
//            name: "LobbyAEON",
//            latitude: CLLocationCoordinate2D.lobbyAeon.latitude,
//            longitude: CLLocationCoordinate2D.lobbyAeon.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_5", "route_7"]
//        ),
//
//        BusStop(
//            id: "lulu",
//            name: "Lulu",
//            latitude: CLLocationCoordinate2D.lulu.latitude,
//            longitude: CLLocationCoordinate2D.lulu.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "masjidAlUkhuwah",
//            name: "MasjidAlUkhuwah",
//            latitude: CLLocationCoordinate2D.masjidAlUkhuwah.latitude,
//            longitude: CLLocationCoordinate2D.masjidAlUkhuwah.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1"]
//        ),
//
//        BusStop(
//            id: "naturale",
//            name: "Naturale",
//            latitude: CLLocationCoordinate2D.naturale.latitude,
//            longitude: CLLocationCoordinate2D.naturale.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "navaPark1",
//            name: "NavaPark1",
//            latitude: CLLocationCoordinate2D.navaPark1.latitude,
//            longitude: CLLocationCoordinate2D.navaPark1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_5"]
//        ),
//
//        BusStop(
//            id: "navaPark2",
//            name: "NavaPark2",
//            latitude: CLLocationCoordinate2D.navaPark2.latitude,
//            longitude: CLLocationCoordinate2D.navaPark2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "pasarModernTimur",
//            name: "PasarModernTimur",
//            latitude: CLLocationCoordinate2D.pasarModernTimur.latitude,
//            longitude: CLLocationCoordinate2D.pasarModernTimur.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "piazziaMozia",
//            name: "PiazziaMozia",
//            latitude: CLLocationCoordinate2D.piazziaMozia.latitude,
//            longitude: CLLocationCoordinate2D.piazziaMozia.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "polsekSerpong",
//            name: "PolsekSerpong",
//            latitude: CLLocationCoordinate2D.polsekSerpong.latitude,
//            longitude: CLLocationCoordinate2D.polsekSerpong.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "prestigia",
//            name: "Prestigia",
//            latitude: CLLocationCoordinate2D.prestigia.latitude,
//            longitude: CLLocationCoordinate2D.prestigia.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "primavera",
//            name: "Primavera",
//            latitude: CLLocationCoordinate2D.primavera.latitude,
//            longitude: CLLocationCoordinate2D.primavera.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "puspitaloka",
//            name: "Puspitaloka",
//            latitude: CLLocationCoordinate2D.puspitaloka.latitude,
//            longitude: CLLocationCoordinate2D.puspitaloka.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "qBig1",
//            name: "QBig1",
//            latitude: CLLocationCoordinate2D.qBig1.latitude,
//            longitude: CLLocationCoordinate2D.qBig1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3", "route_7"]
//        ),
//
//        BusStop(
//            id: "qBig2",
//            name: "QBig2",
//            latitude: CLLocationCoordinate2D.qBig2.latitude,
//            longitude: CLLocationCoordinate2D.qBig2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "qBig3",
//            name: "QBig3",
//            latitude: CLLocationCoordinate2D.qBig3.latitude,
//            longitude: CLLocationCoordinate2D.qBig3.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "rukoMadrid",
//            name: "RukoMadrid",
//            latitude: CLLocationCoordinate2D.rukoMadrid.latitude,
//            longitude: CLLocationCoordinate2D.rukoMadrid.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "rukoTheLoop",
//            name: "RukoTheLoop",
//            latitude: CLLocationCoordinate2D.rukoTheLoop.latitude,
//            longitude: CLLocationCoordinate2D.rukoTheLoop.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "santaUrsula1",
//            name: "SantaUrsula1",
//            latitude: CLLocationCoordinate2D.santaUrsula1.latitude,
//            longitude: CLLocationCoordinate2D.santaUrsula1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "santaUrsula2",
//            name: "SantaUrsula2",
//            latitude: CLLocationCoordinate2D.santaUrsula2.latitude,
//            longitude: CLLocationCoordinate2D.santaUrsula2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "saveria",
//            name: "Saveria",
//            latitude: CLLocationCoordinate2D.saveria.latitude,
//            longitude: CLLocationCoordinate2D.saveria.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_4", "route_7"]
//        ),
//
//        BusStop(
//            id: "sektor13",
//            name: "Sektor1.3",
//            latitude: CLLocationCoordinate2D.sektor13.latitude,
//            longitude: CLLocationCoordinate2D.sektor13.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "sentraOnderdil",
//            name: "SentraOnderdil",
//            latitude: CLLocationCoordinate2D.sentraOnderdil.latitude,
//            longitude: CLLocationCoordinate2D.sentraOnderdil.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "simpangForesta",
//            name: "SimpangForesta",
//            latitude: CLLocationCoordinate2D.simpangForesta.latitude,
//            longitude: CLLocationCoordinate2D.simpangForesta.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "simplicity1",
//            name: "Simplicity1",
//            latitude: CLLocationCoordinate2D.simplicity1.latitude,
//            longitude: CLLocationCoordinate2D.simplicity1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_4", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "simplicity2",
//            name: "Simplicity2",
//            latitude: CLLocationCoordinate2D.simplicity2.latitude,
//            longitude: CLLocationCoordinate2D.simplicity2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3", "route_6", "route_7"]
//        ),
//
//        BusStop(
//            id: "smlPlaza",
//            name: "SMLPlaza",
//            latitude: CLLocationCoordinate2D.smlPlaza.latitude,
//            longitude: CLLocationCoordinate2D.smlPlaza.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_3", "route_4", "route_7"]
//        ),
//        
//        
//        BusStop(
//            id: "studento1",
//            name: "Studento1",
//            latitude: CLLocationCoordinate2D.studento1.latitude,
//            longitude: CLLocationCoordinate2D.studento1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_4"]
//        ),
//
//        BusStop(
//            id: "studento2",
//            name: "Studento2",
//            latitude: CLLocationCoordinate2D.studento2.latitude,
//            longitude: CLLocationCoordinate2D.studento2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_2", "route_3"]
//        ),
//
//        BusStop(
//            id: "swa1",
//            name: "Swa1",
//            latitude: CLLocationCoordinate2D.swa1.latitude,
//            longitude: CLLocationCoordinate2D.swa1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "swa2",
//            name: "Swa2",
//            latitude: CLLocationCoordinate2D.swa2.latitude,
//            longitude: CLLocationCoordinate2D.swa2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2"]
//        ),
//
//        BusStop(
//            id: "tabebuya",
//            name: "Tabebuya",
//            latitude: CLLocationCoordinate2D.tabebuya.latitude,
//            longitude: CLLocationCoordinate2D.tabebuya.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "theBreeze",
//            name: "TheBreeze",
//            latitude: CLLocationCoordinate2D.theBreeze.latitude,
//            longitude: CLLocationCoordinate2D.theBreeze.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_2", "route_3", "route_4", "route_5", "route_7"]
//        ),
//
//        BusStop(
//            id: "theMozia1",
//            name: "TheMozia1",
//            latitude: CLLocationCoordinate2D.theMozia1.latitude,
//            longitude: CLLocationCoordinate2D.theMozia1.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "theMozia2",
//            name: "TheMozia2",
//            latitude: CLLocationCoordinate2D.theMozia2.latitude,
//            longitude: CLLocationCoordinate2D.theMozia2.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "vanyaPark",
//            name: "VanyaPark",
//            latitude: CLLocationCoordinate2D.vanyaPark.latitude,
//            longitude: CLLocationCoordinate2D.vanyaPark.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        ),
//
//        BusStop(
//            id: "verdantView",
//            name: "VerdantView",
//            latitude: CLLocationCoordinate2D.verdantView.latitude,
//            longitude: CLLocationCoordinate2D.verdantView.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_1", "route_3"]
//        ),
//
//        BusStop(
//            id: "westPark",
//            name: "WestPark",
//            latitude: CLLocationCoordinate2D.westPark.latitude,
//            longitude: CLLocationCoordinate2D.westPark.longitude,
//            images: ["Intermoda_1"],
//            routes: ["route_6"]
//        )
//    ]
    
    
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
