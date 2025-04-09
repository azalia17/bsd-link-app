//
//  LocationSearchViewModel.swift
//  BSDLink
//
//  Created by Azalia Amanda on 07/04/25.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var results = [MKLocalSearchCompletion]()
    //    @Published var selectedStartLocation: String = ""
    //    @Published var selectedEndLocation: String = ""
    
    //the selected from the list
    var startLocationSearch: MKLocalSearchCompletion = MKLocalSearchCompletion()
    var endLocationSearch: MKLocalSearchCompletion = MKLocalSearchCompletion()
    
    // for anotation
    @Published var selectedStartCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @Published var selectedEndCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    // what shown on the text field
    private let startLocactionSearchCompleter = MKLocalSearchCompleter()
    @Published var startLocationQueryFragment: String = "" {
        didSet {
            startLocactionSearchCompleter.queryFragment = startLocationQueryFragment
        }
    }
    
    private let endLocactionSearchCompleter = MKLocalSearchCompleter()
    @Published var endLocationQueryFragment: String = "" {
        didSet {
            endLocactionSearchCompleter.queryFragment = endLocationQueryFragment
        }
    }
    
    /*@Published */var route: MKRoute?
    /*@Published*/ var routePolylines: [MKPolyline] = []
    
//    @Published var busStopsGenerated: [CLLocationCoordinate2D] = []
    @Published var busStopsGenerated: [IdentifiableCoordinate] = []
    @Published var bestRoutes: [Route] = []
    
    override init() {
        super.init()
        
        startLocactionSearchCompleter.delegate = self
        startLocactionSearchCompleter.queryFragment = startLocationQueryFragment
        
        endLocactionSearchCompleter.delegate = self
        endLocactionSearchCompleter.queryFragment = endLocationQueryFragment
    }
    
    func selectLocation(_ location: MKLocalSearchCompletion, textField: String) {
        if (textField == "from") {
            self.startLocationQueryFragment = location.title
            self.startLocationSearch = location
        } else {
            self.endLocationQueryFragment = location.title
            self.endLocationSearch = location
        }
    }
    
    func searchDirection() {
        print("start searchDirection()")
        locationSearch(forLocalSearchCompletion: startLocationSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            self.selectedStartCoordinate = coordinate
        }
        
        locationSearch(forLocalSearchCompletion: endLocationSearch) { response, error in
            if let error = error {
                print("DEBUG: Location search failed with error \(error.localizedDescription)")
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            
            self.selectedEndCoordinate = coordinate
        }
    }
    
    func reset() {
        self.endLocationQueryFragment = ""
        self.startLocationQueryFragment = ""
        self.startLocationQueryFragment = ""
        self.endLocationQueryFragment = ""
        self.selectedEndCoordinate = CLLocationCoordinate2D()
        self.selectedStartCoordinate = CLLocationCoordinate2D()
    }
    
    func swapDestination(start: MKLocalSearchCompletion, end: MKLocalSearchCompletion) {
        self.startLocationQueryFragment = end.title
        self.startLocationSearch = end
        
        self.endLocationQueryFragment = start.title
        self.endLocationSearch = start
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    /** From Discover View **/
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        
        do {
            let update = try await updates.first { $0.location?.coordinate != nil }
            //            userLocation = update?.location?.coordinate
            return update?.location?.coordinate
        } catch {
            print("Cannot get user location")
            return nil
        }
    }
    
    func getDirections() {
        Task {
            let waypoints: [CLLocationCoordinate2D] = [
                self.selectedStartCoordinate,
                self.selectedEndCoordinate
            ]
            
            guard waypoints.count >= 2 else { return }
            
            self.routePolylines.removeAll()
            
            for index in 0..<waypoints.count - 1 {
                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: waypoints[index]))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: waypoints[index + 1]))
                request.transportType = .automobile
                
                do {
                    let directions = try await MKDirections(request: request).calculate()
                    if let route = directions.routes.first {
                        self.routePolylines.append(route.polyline)
                    }
                } catch {
                    print("Error calculating route: \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func getWalkingDirections(/*to destination: CLLocationCoordinate2D*/) {
        Task {
            guard let userLocation = await getUserLocation() else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation))
            request.destination = MKMapItem(placemark: .init(coordinate: self.selectedStartCoordinate))
            request.transportType = .walking
            
            do {
                let directions = try await MKDirections(request: request).calculate()
                self.route = directions.routes.first
            } catch {
                print("Show error")
            }
        }
        //        return route
    }
    
    func findNearestBusStop(from userLocation: CLLocationCoordinate2D) -> BusStop? {
        let userLocationCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        // Find the nearest bus stop by calculating the distance to each bus stop
        var nearestBusStop: BusStop?
        var shortestDistance: CLLocationDistance = CLLocationDistanceMax
        
        for busStop in BusStop.all {
            let busStopLocation = CLLocation(latitude: busStop.latitude, longitude: busStop.longitude)
            let distance = userLocationCLLocation.distance(from: busStopLocation)
            
            if distance < shortestDistance {
                shortestDistance = distance
                nearestBusStop = busStop
            }
        }
        
        return nearestBusStop
    }
    
    func findRoutes(for busStop: BusStop) -> [Route] {
        var matchingRoutes: [Route] = []
        
        for route in Route.all {
            if route.busStops.contains(busStop.id) {
                matchingRoutes.append(route)
            }
        }
        
        return matchingRoutes
    }
    
//    func generateRoute(from startLocation: CLLocationCoordinate2D, to endLocation: CLLocationCoordinate2D) -> (startBusStop: BusStop, endBusStop: BusStop, routes: [Route])? {
//        // Find the nearest start bus stop
//        guard let startBusStop = findNearestBusStop(from: startLocation) else {
//            print("No nearby start bus stop found.")
//            return nil
//        }
//        
//        // Find the nearest end bus stop
//        guard let endBusStop = findNearestBusStop(from: endLocation) else {
//            print("No nearby end bus stop found.")
//            return nil
//        }
//        
//        print("start: \(selectedStartCoordinate)")
//        print("end: \(selectedEndCoordinate)")
//        print("start stop \(startBusStop), end stop \(endBusStop)")
//        
//        // Find routes that pass through the start and end bus stops
//        let startRoutes = findRoutes(for: startBusStop)
//        let endRoutes = findRoutes(for: endBusStop)
//        
//        // Filter routes that pass through both the start and end bus stops
//        let matchingRoutes = startRoutes.filter { route in
//            return endRoutes.contains { $0.id == route.id }
//        }
//        
//        print("matchingRoutes")
//        
//        if matchingRoutes.isEmpty {
//            print("No matching routes found.")
//            return nil
//        }
//        
//        ////        if let routeDetails = locationViewModel.generateRoute() {
//        //            let sStartBusStop = startBusStop
//        //            let eEndBusStop = endBusStop
//        //            let rRoutes = matchingRoutes
//        
//        // Generate the bus stops the user will pass through based on the first matching route
//        if let busStopsOnRoute = self.generateBusStops(from: startBusStop, to: endBusStop, routes: matchingRoutes) {
//            // Print out the bus stops
//            for busStop in busStopsOnRoute {
//                print("Bus stop: \(busStop.name)")
//            }
//        } else {
//            // Generate paths with possible transfers considering transit bus stops
//            let pathsWithTransfers = self.generatePathsWithTransfers(startBusStop: startBusStop, endBusStop: endBusStop, routes: matchingRoutes)
//            
//            // Print out the possible paths
//            for (index, path) in pathsWithTransfers.enumerated() {
//                print("Path \(index + 1):")
//                for busStop in path {
//                    print("  \(busStop.name)")
//                }
//            }
//        }
//        return (startBusStop, endBusStop, matchingRoutes)
//    }
    
    func generateBusStops(from startBusStop: BusStop, to endBusStop: BusStop, routes: [Route]) -> [BusStop]? {
        var bestRoute: Route? = nil
        var bestBusStops: [BusStop]? = nil
        var minBusStopsCount = Int.max  // We will use this to track the route with the least bus stops

        // Iterate over each route to find the valid routes with start and end bus stops
        for route in routes {
            print("\nChecking route: \(route.name) id: \(route.id)\n")
            
            if let startIndex = route.busStops.firstIndex(of: startBusStop.id),
               let endIndex = route.busStops.firstIndex(of: endBusStop.id),
               startIndex <= endIndex {
                
                // Get the bus stops between start and end indices (inclusive)
                let busStopIDs = Array(route.busStops[startIndex...endIndex])
                
                // Convert the bus stop IDs to BusStop objects
                let busStopsOnRoute = busStopIDs.compactMap { busStopID in
                    return BusStop.all.first { $0.id == busStopID }
                }
                
                print("busStopsOnRoute \(busStopsOnRoute)\n")
                
                // Compare the count of bus stops with the current minimum
                if busStopsOnRoute.count < minBusStopsCount {
                    minBusStopsCount = busStopsOnRoute.count
                    bestRoute = route  // Update the best route with the least bus stops
                    bestBusStops = busStopsOnRoute  // Update the best route with the least bus stops
                }
            }
        }
        bestRoutes = [bestRoute ?? Route(id: "xx", name: "Xx", routeNumber: 0, busStops: [], bus: [], schedule: [], note: [])]
        
        generateBusStopCoordinates(from: bestBusStops ?? [])
        
        
        // Return the bus stops with the least number of stops, or nil if no valid route was found
        return bestBusStops
    }
    
//    func generateBusStops(from startBusStop: BusStop, to endBusStop: BusStop, routes: [Route]) -> (Route?, [BusStop]?) {
//        var bestRoute: Route? = nil
//        var bestBusStops: [BusStop]? = nil
//        var minBusStopsCount = Int.max  // We will use this to track the route with the least bus stops
//
//        // Iterate over each route to find the valid routes with start and end bus stops
//        for route in routes {
//            print("\nChecking route: \(route.name) id: \(route.id)\n")
//            
//            if let startIndex = route.busStops.firstIndex(of: startBusStop.id),
//               let endIndex = route.busStops.firstIndex(of: endBusStop.id),
//               startIndex <= endIndex {
//                
//                // Get the bus stops between start and end indices (inclusive)
//                let busStopIDs = Array(route.busStops[startIndex...endIndex])
//                
//                // Convert the bus stop IDs to BusStop objects
//                let busStopsOnRoute = busStopIDs.compactMap { busStopID in
//                    return BusStop.all.first { $0.id == busStopID }
//                }
//                
//                print("busStopsOnRoute \(busStopsOnRoute)\n")
//                
//                // Compare the count of bus stops with the current minimum
//                if busStopsOnRoute.count < minBusStopsCount {
//                    minBusStopsCount = busStopsOnRoute.count
//                    bestRoute = route  // Update the best route with the least bus stops
//                    bestBusStops = busStopsOnRoute  // Update the best bus stops
//                }
//            }
//        }
//        
//        bestRoutes = [bestRoute]
//
//        // Return the best route with the least number of bus stops, and the bus stops along that route
//        return (bestBusStops)
//    }

    
    func generateBusStopCoordinates(from busStops: [BusStop]) {
        busStopsGenerated = busStops.map { busStop in
            return IdentifiableCoordinate(coordinate: CLLocationCoordinate2D(latitude: busStop.latitude, longitude: busStop.longitude), busStopName: busStop.name)
        }
    }

    
    func generatePathsWithTransfers(startBusStop: BusStop, endBusStop: BusStop, routes: [Route]) -> [[BusStop]] {
        var possiblePaths: [[BusStop]] = []
        
        // Find transit bus stops (those that appear in multiple routes)
        let transitBusStops = BusStop.all.filter { $0.isTransitStop }
        
        // Iterate through routes to find possible paths with transfers
        for route in routes {
            // Check if the route contains both start and end bus stops
            if let startIndex = route.busStops.firstIndex(of: startBusStop.id),
               let endIndex = route.busStops.firstIndex(of: endBusStop.id),
               startIndex <= endIndex {
                
                // Generate path for this route without transferring
                let busStopsOnRoute = Array(route.busStops[startIndex...endIndex]).compactMap { busStopID in
                    return BusStop.all.first { $0.id == busStopID }
                }
                possiblePaths.append(busStopsOnRoute)
                
                // Now, check for paths with transfers
                for transitBusStop in transitBusStops {
                    // Check if the transit bus stop exists in this route
                    if let transferIndex = route.busStops.firstIndex(of: transitBusStop.id),
                       transferIndex > startIndex {
                        
                        // Split the route at the transfer point and create a path with transfer
                        let firstPart = Array(route.busStops[startIndex...transferIndex])
                        let secondPart = Array(route.busStops[transferIndex...endIndex])
                        
                        let firstPath = firstPart.compactMap { busStopID in
                            return BusStop.all.first { $0.id == busStopID }
                        }
                        let secondPath = secondPart.compactMap { busStopID in
                            return BusStop.all.first { $0.id == busStopID }
                        }
                        
                        possiblePaths.append(firstPath + secondPath)
                    }
                }
            }
        }
        
        return possiblePaths
    }
    
    
    
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}

struct IdentifiableCoordinate: Identifiable {
    let id = UUID() // Automatically generates a unique ID
    let coordinate: CLLocationCoordinate2D
    let busStopName: String
}
