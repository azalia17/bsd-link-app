//
//  DiscoverView.swift
//  BSDLink
//
//  Created by Azalia Amanda on 23/03/25.
//

import SwiftUI
import MapKit

struct DiscoverView: View {
    var cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: -6.305968, longitude: 106.672272), latitudinalMeters: 13000, longitudinalMeters: 13000))
    
    let locationManager = CLLocationManager()
    @State private var routePolylines: [MKPolyline] = []
    @State private var startingPoint: String = ""
    @State private var destinationPoint: String = ""
    @State private var activeTextField: String = ""
    
    @State private var startingCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var destinationCoordiante: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @State private var showResultRoute = false
    @State private var route: MKRoute?
    @State private var routeEndDestination: MKRoute?
    @State private var routeStartDestination: MKRoute?
    
    @State private var isSearch: Bool = false
    @State private var showTimePicker: Bool = false
    @State private var showPopover: Bool = false
    @State private var timePicked = Date()
    @State private var isTimePicked: Bool = false
    
    @State private var showLocationSearchView: Bool = false
    
    @State var bestRoutes: [Route] = []
    
    @State var openSheet: Bool = false
    
    @State private var shouldRetry = false

    @State private var previousStartCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var previousEndCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Map(initialPosition: cameraPosition) {
                
                if isSearch {
                    Marker(locationViewModel.startLocationQueryFragment, systemImage: "mappin.circle.fill", coordinate: locationViewModel.selectedStartCoordinate)
                        .tint(.red.gradient)
                    
                    Marker(locationViewModel.endLocationQueryFragment, systemImage: "flag.circle.fill", coordinate: locationViewModel.selectedEndCoordinate)
                        .tint(.red.gradient)
                    
                    ForEach(locationViewModel.busStopsGenerated) { identifiableCoordinate in
                        Marker(identifiableCoordinate.busStopName,
                               systemImage: "bus",
                               coordinate: identifiableCoordinate.coordinate
                        ) // Access the coordinate here
                        .tint(.orange.gradient)
                    }
                    
                }
                
                UserAnnotation().tint(.blue)
                
//                if route != nil{
//                    MapPolyline(route!)
//                        .stroke(.blue, style: StrokeStyle(lineWidth: 1, dash: [6, 3]))
//                }
                if routeStartDestination != nil && isSearch {
                    MapPolyline(routeStartDestination!)
                        .stroke(.orange, style: StrokeStyle(lineWidth: 1, dash: [6, 3]))
                }
                if routeEndDestination != nil && isSearch {
                    MapPolyline(routeEndDestination!)
                        .stroke(.orange, style: StrokeStyle(lineWidth: 1, dash: [6, 3]))
                }
                if isSearch{
                    ForEach(routePolylines, id: \.self) { polyline in
                        MapPolyline(polyline)
                            .stroke(.orange, lineWidth: 3)
                    }
                }
            }
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            .mapStyle(.standard(elevation: .realistic))
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    if(!isSearch){
                        SearchCard(
                            searchHandler: {},
                            filterHandler: {
                                showTimePicker = true
                            },
                            swapHandler: {},
                            resetResultsCompletion: {},
                            startingPoint: $startingPoint,
                            destinationPoint: $destinationPoint,
                            activeTextField: $activeTextField,
                            isTimePicked: $isTimePicked,
                            showSearchLocationView: $showLocationSearchView) {
                                showLocationSearchView.toggle()
                            }
                        
                        
                        QuickSearch(
                            startingPoint: $startingPoint,
                            destinationPoint: $destinationPoint
                        )
                    } else {
                        HStack {
                            //                            Button()
                            Button("Search", systemImage: "chevron.backward") {
//                                isSearch = false
//                                showLocationSearchView = true
//                                locationViewModel.reset()
//                                routePolylines.removeAll()
//                                route = MKRoute()
//                                bestRoutes = []
//                                openSheet = false
//                                routeEndDestination = MKRoute()
//                                routeStartDestination = MKRoute()
//                                previousStartCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
//                                previousEndCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
                                
                                isSearch = false
                                    showLocationSearchView = true
                                    locationViewModel.reset()  // Assuming this method resets the location view model

                                    // Reset coordinates
//                                previousStartCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
//                                previousEndCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)

                                    // Reset any routes or route polylines
                                    routePolylines.removeAll()
                                route = MKRoute()
                                    routeStartDestination = MKRoute()
                                    routeEndDestination = MKRoute()
                                    bestRoutes = []

                                    // Optionally, reset any other UI elements like text fields, labels, etc.
                                    startingPoint = ""
                                    destinationPoint = ""
                                    activeTextField = ""

                                    // Reset time-related data if necessary
                                    timePicked = Date()
                                    isTimePicked = false
                                
                            }
                            .frame(height: 35, alignment: .center)
                            .labelStyle(.iconOnly)
                            .buttonStyle(.borderedProminent)
                            .tint(.white)
                            .foregroundColor(.black)
                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                            
                            HStack{
                                Text(locationViewModel.startLocationQueryFragment)
                                    .lineLimit(1)
                                Image(systemName: "arrow.forward")
                                Text(locationViewModel.endLocationQueryFragment)
                                    .lineLimit(1)
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            )
                            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
                            
                            
                        }
                    }
                    Spacer()
                }
                .safeAreaPadding()
                .frame(height: 150)
                .padding(.bottom)
                .background(isSearch ? .gray.opacity(0.0) : .gray.opacity(0.27))
                .background(isSearch ? .white.opacity(0.0) : .white.opacity(0.9))
            }
            .sheet(isPresented: $showTimePicker) {
                VStack {
                    TimePicker(showTimePicker: $showTimePicker, timePicked: $timePicked, isTimePicked: $isTimePicked)
                        .presentationDetents([.fraction(0.45)])
                }
            }
            
            if isSearch {
                
                DraggableSheet(
                    routes: bestRoutes,
//                    routes: [Route.all[0]],
//                    routes: Route.all.filter {$0.id == bestRoutes[0].id},
//                    routes: locationViewModel.bestRoutes,
                    fromHour: 6,
                    fromMinute: 0
                )
                .edgesIgnoringSafeArea(.bottom)
                .transition(.move(edge: .bottom))
//                .visib
            }
            
            if showLocationSearchView {
                LocationSearchView(
                    isTimePicked: $isTimePicked,
                    showSearchLocationView: $showLocationSearchView,
                    isSearch: $isSearch) {
                        locationViewModel.searchDirection()
                        getWalkingDirections()
                        getDirections()
                        
                    }
                    .environmentObject(locationViewModel)
                    .onDisappear {
                        locationViewModel.searchDirection()
                        getDirections()
                        getWalkingDirections()
                        
                    }
            }

        }
        .onChange(of: locationViewModel.selectedStartCoordinate) { newCoordinate in
            // Trigger retry if the coordinates are valid and different from previous ones
            if shouldRetry && newCoordinate != previousStartCoordinate {
                previousStartCoordinate = newCoordinate
                if newCoordinate.latitude != 0.0 && newCoordinate.longitude != 0.0 {
                    getDirections() // Retry the route generation
                }
            }
        }

        
    }
    
    
    
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
    
    func swapDirections(start: String, destination: String) {
        startingPoint = destination
        destinationPoint = start
    }
    
    func getDirections() {
        // Check if both the start and end coordinates are valid (i.e., not 0.0, 0.0)
        guard locationViewModel.selectedStartCoordinate.latitude != 0.0,
              locationViewModel.selectedStartCoordinate.longitude != 0.0,
              locationViewModel.selectedEndCoordinate.latitude != 0.0,
              locationViewModel.selectedEndCoordinate.longitude != 0.0 else {
            print("Invalid coordinates, retrying once valid coordinates are available.")
            shouldRetry = true // Set the flag to retry once coordinates are valid
            return
        }

        // Reset retry flag before proceeding with the route generation
        shouldRetry = false
        
        print("start getDirection()")
        
        routePolylines.removeAll()
                    route = nil
                    routeStartDestination = nil
                    routeEndDestination = nil
        
        Task {
//            locationViewModel.searchDirection()
            if let routeDetails = generateRoute(from: locationViewModel.selectedStartCoordinate, to: locationViewModel.selectedEndCoordinate) {
                let startBusStop = routeDetails.startBusStop
                let endBusStop = routeDetails.endBusStop
                let routes = routeDetails.routes
                
                
                // Generate the bus stops the user will pass through based on the first matching route
                if let busStopsOnRoute = locationViewModel.generateBusStops(from: startBusStop, to: endBusStop, routes: routes) {
                    // Print out the bus stops
                    for busStop in busStopsOnRoute {
                        print("\"\(busStop.id)\",")
                    }
                    
                } else {
                    // Generate paths with possible transfers considering transit bus stops
                    let pathsWithTransfers = locationViewModel.generatePathsWithTransfers(startBusStop: startBusStop, endBusStop: endBusStop, routes: routes)
                    
                    // Print out the possible paths
                    for (index, path) in pathsWithTransfers.enumerated() {
                        print("Path \(index + 1):")
                        for busStop in path {
                            print("  \(busStop.name)")
                        }
                    }
                }
                
                /**Start**/
                

                // Define your list of bus stops to search for
                

                // Define a function to find the route that matches the bus stops in order
                func findRoute(forBusStops busStopsToSearch: [String], in routes: [Route]) -> Route? {
                    // Iterate over each route
                    for route in routes {
                        let busStops = route.busStops
                        
                        // Check if the busStops in the route match the busStopsToSearch in the exact order
                        if isSubsequence(busStopsToSearch, in: busStops) {
                            return route
                        }
                    }
                    
                    // If no route matches, return nil
                    return nil
                }

                // Helper function to check if busStopsToSearch is a subsequence of busStops in the correct order
                func isSubsequence(_ subsequence: [String], in sequence: [String]) -> Bool {
                    var subsequenceIndex = 0
                    for stop in sequence {
                        if subsequenceIndex < subsequence.count && subsequence[subsequenceIndex] == stop {
                            subsequenceIndex += 1
                        }
                        if subsequenceIndex == subsequence.count {
                            return true
                        }
                    }
                    return false
                }

                // Usage
                if let matchingRoute = findRoute(forBusStops: locationViewModel.busStopsGenerated.map{ $0.busStopId }, in: Route.all) {
                    print("Found route: \(matchingRoute.name), \(matchingRoute.id)")
                    bestRoutes = [matchingRoute]
                } else {
                    print("No matching route found")
                }

                
                /**END*/
                
//                bestRoutes = locationViewModel.bestRoutes
                //                routes
                let waypoints: [CLLocationCoordinate2D] = locationViewModel.busStopsGenerated.map { $0.coordinate }
                
                //                let waypoints: [CLLocationCoordinate2D] = locationViewModel.busStopsGenerated
                //                [
                //                    CLLocationCoordinate2D(latitude: startBusStop.latitude, longitude: startBusStop.longitude),
                //                    CLLocationCoordinate2D(latitude: endBusStop.latitude, longitude: endBusStop.longitude)
                
                //                ]
                
                guard waypoints.count >= 2 else { return }
                
                routePolylines.removeAll()
                
                for index in 0..<waypoints.count - 1 {
                    let request = MKDirections.Request()
                    request.source = MKMapItem(placemark: MKPlacemark(coordinate: waypoints[index]))
                    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: waypoints[index + 1]))
                    request.transportType = .automobile
                    
                    do {
                        let directions = try await MKDirections(request: request).calculate()
                        if let route = directions.routes.first {
                            routePolylines.append(route.polyline)
                        }
                    } catch {
                        print("Error calculating route: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Could not generate a route.")
            }
            
            openSheet = true
        }
    }
    
    func getWalkingDirections() {
        Task {
            guard let userLocation = await getUserLocation() else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation))
            request.destination = MKMapItem(placemark: .init(coordinate: locationViewModel.selectedStartCoordinate))
            request.transportType = .walking
            
            do {
                let directions = try await MKDirections(request: request).calculate()
                route = directions.routes.first
            } catch {
                print("Show error")
            }
        }
    }
    
    func getWalkingFromStopsDirections(from start: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, type: String ) {
        Task {
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: start))
            request.destination = MKMapItem(placemark: .init(coordinate: destination))
            request.transportType = .walking
            
            do {
                let directions = try await MKDirections(request: request).calculate()
                if (type == "start") {
                    routeStartDestination = directions.routes.first
                } else {
                    routeEndDestination = directions.routes.first
                }
            } catch {
                print("Show error")
            }
        }
    }
    func generateRoute(from startLocation: CLLocationCoordinate2D, to endLocation: CLLocationCoordinate2D) -> (startBusStop: BusStop, endBusStop: BusStop, routes: [Route])? {
        print("start generateRoute()")
        
        // Find the nearest start bus stop
        guard let startBusStop = locationViewModel.findNearestBusStop(from: startLocation) else {
            print("No nearby start bus stop found.")
            return nil
        }
        
        // Find the nearest end bus stop
        guard let endBusStop = locationViewModel.findNearestBusStop(from: endLocation) else {
            print("No nearby end bus stop found.")
            return nil
        }
        
        // Find routes that pass through the start and end bus stops
        let startRoutes = locationViewModel.findRoutes(for: startBusStop)
        let endRoutes = locationViewModel.findRoutes(for: endBusStop)
        
        print("start: \(startLocation)")
        print("end: \(endLocation)")
        print("start stop \(startBusStop), end stop \(endBusStop)")
        
        getWalkingFromStopsDirections(from: startLocation, to: CLLocationCoordinate2D(latitude: startBusStop.latitude, longitude: startBusStop.longitude), type: "start")
        getWalkingFromStopsDirections(from: endLocation, to: CLLocationCoordinate2D(latitude: endBusStop.latitude, longitude: endBusStop.longitude), type: "end")
        
        // Filter routes that pass through both the start and end bus stops
        let matchingRoutes = startRoutes.filter { route in
            return endRoutes.contains { $0.id == route.id }
        }
        
        if matchingRoutes.isEmpty {
            print("No matching routes found.")
            return nil
        }
        
        // Return the result with the nearest bus stops and matching routes
        return (startBusStop, endBusStop, matchingRoutes)
    }
    
}


struct DraggableSheet: View {
    var routes: [Route]
    let fromHour: Int
    let fromMinute: Int
    
    @State private var offsetY: CGFloat = 400 // Default height (collapsed)
    @State private var screenHeight: CGFloat = 0 // Store screen height
    
    var body: some View {
        GeometryReader { geometry in
            let fullHeight = geometry.size.height
            let minHeight: CGFloat = fullHeight * 0.2 // Minimum collapsed height (10pt)
            let midHeight = fullHeight * 0.6 // 80% of the screen
            let maxHeight = fullHeight // Fully expanded
            
            DiscoverDetailRoute(
                routes: routes,
                fromHour: fromHour,
                fromMinute: fromMinute
            )
            .frame(height: max(minHeight, min(maxHeight, fullHeight - offsetY)))
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        let newOffset = offsetY + gesture.translation.height
                        if newOffset >= 0 && newOffset <= fullHeight - minHeight {
                            offsetY = newOffset
                        }
                    }
                    .onEnded { _ in
                        withAnimation {
                            let threshold = (fullHeight - midHeight) / 2
                            
                            if offsetY > fullHeight - midHeight + threshold {
                                offsetY = fullHeight - minHeight // Snap to 10pt height
                            } else if offsetY > threshold {
                                offsetY = fullHeight - midHeight // Snap to 80% height
                            } else {
                                offsetY = 0 // Fully expanded
                            }
                        }
                    }
            )
            .onAppear {
                screenHeight = fullHeight
                offsetY = fullHeight - midHeight // Start at 80% height
            }
            .edgesIgnoringSafeArea(.bottom)
            .transition(.move(edge: .bottom))
        }
    }
    
    
    
}
