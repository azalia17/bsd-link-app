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
    
    //    var cameraPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: CLLocationCoordinate2D(latitude: -6.305968, longitude: 106.672272), distance: 400000.0, heading: 0, pitch: 0))
    
    
    
    let locationManager = CLLocationManager()
    @State private var routePolylines: [MKPolyline] = []
    @State private var startingPoint: String = ""
    @State private var destinationPoint: String = ""
    @State private var activeTextField: String = ""
    
//    private var startCoordinate: CLLocationCoordinate2D
    
    @State private var startingCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var destinationCoordiante: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @State private var showResultRoute = false
    @State private var route: MKRoute?
    
    @State private var isSearch: Bool = false
    @State private var showTimePicker: Bool = false
    @State private var showPopover: Bool = false
    @State private var timePicked = Date()
    @State private var isTimePicked: Bool = false
    
    @State private var showLocationSearchView: Bool = false
    
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Map(initialPosition: cameraPosition) {
                
                if isSearch {
                    Marker(locationViewModel.startLocationQueryFragment, systemImage: "bus", coordinate: locationViewModel.selectedStartCoordinate)
                        .tint(.orange.gradient)
                    
                    Marker(locationViewModel.endLocationQueryFragment, systemImage: "bus", coordinate: locationViewModel.selectedEndCoordinate)
                        .tint(.orange.gradient)
                    //
                    //                    Annotation("Istiqlal", coordinate: .istiqlal, anchor: .bottom) {
                    //                        Image(systemName: "moon.fill")
                    //                            .resizable()
                    //                            .aspectRatio(contentMode: .fit)
                    //                            .foregroundStyle(.white)
                    //                            .frame(width: 30, height: 30)
                    //                            .padding(7)
                    //                            .background(.orange.gradient, in: .circle)
                    //                    }
                }
                
                UserAnnotation()
                
                if route != nil{
                    MapPolyline(route!)
                        .stroke(.orange, style: StrokeStyle(lineWidth: 1, dash: [6, 3]))
                }
                ForEach(routePolylines, id: \.self) { polyline in
                    MapPolyline(polyline)
                        .stroke(.orange, lineWidth: 3)
                }
            }
            .task {
                //            guard let userCoordinate = await getUserLocation() else { return }
                ////            if let userLocation = locationManager.currentLocation {
                //                cameraPosition = .camera(MapCamera(centerCoordinate: userCoordinate, distance: 400000.0, heading: 0, pitch: 0))
                ////                }
                //            getUserLocation()
                //            guard let userLocation2 = await getUserLocation() else { return }
                //            do {
                //                userLocation = userLocation2
                //            } catch {
                //                print("Error fetch user")
                //            }
            }
            .tint(.orange)
            .onAppear {
                locationManager.requestWhenInUseAuthorization()
            }
            .mapControls {
                
                //            MapUserLocationButton()
                //            MapCompass()
                //            MapPitchToggle()
                //            MapScaleView()
            }
            .mapStyle(.standard(elevation: .realistic))
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    if(!isSearch){
                        SearchCard(
                            searchHandler: {
                                //                                getWalkingDirections(to: .bbb)
                                //                                getDirections()
                                //                                isSearch = true
                            },
                            filterHandler: {
                                showTimePicker = true
                            },
                            swapHandler: {
                                //                                swapDirections(
                                //                                    start: startingPoint,
                                //                                    destination: destinationPoint
                                //                                )
                            },
                            startingPoint: $startingPoint,
                            destinationPoint: $destinationPoint,
                            activeTextField: $activeTextField,
                            isTimePicked: $isTimePicked,
                            showSearchLocationView: $showLocationSearchView) {
                                //                                if let routeDetails = locationViewModel.generateRoute(from: .gramedia, to: .eternity) {
                                //                                    let startBusStop = routeDetails.startBusStop
                                //                                    let endBusStop = routeDetails.endBusStop
                                //                                    let routes = routeDetails.routes
                                //
                                //                                    // Generate the bus stops the user will pass through based on the first matching route
                                //                                    if let busStopsOnRoute = locationViewModel.generateBusStops(from: startBusStop, to: endBusStop, routes: routes) {
                                //                                        // Print out the bus stops
                                //                                        for busStop in busStopsOnRoute {
                                //                                            print("Bus stop: \(busStop.name)")
                                //                                        }
                                //                                    } else {
                                //
                                //
                                //                                        // Generate paths with possible transfers considering transit bus stops
                                //                                        let pathsWithTransfers = locationViewModel.generatePathsWithTransfers(startBusStop: startBusStop, endBusStop: endBusStop, routes: routes)
                                //
                                //                                        // Print out the possible paths
                                //                                        for (index, path) in pathsWithTransfers.enumerated() {
                                //                                            print("Path \(index + 1):")
                                //                                            for busStop in path {
                                //                                                print("  \(busStop.name)")
                                //                                            }
                                //                                        }
                                //                                    }
                                //                                } else {
                                //
                                //                                    print("Could not generate a route.")
                                //                                }
                                
                                
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
                                isSearch = false
                                showLocationSearchView = true
                                locationViewModel.reset()
                                routePolylines.removeAll()
                                route = MKRoute()
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
                        Spacer()
                    }
                }
                .safeAreaPadding()
                .frame(height: 150)
                .padding(.bottom)
                .background(isSearch ? .gray.opacity(0.0) : .gray.opacity(0.27))
                .background(isSearch ? .white.opacity(0.0) : .white.opacity(0.9))
                .sheet(isPresented: $showTimePicker) {
                    VStack {
                        TimePicker(showTimePicker: $showTimePicker, timePicked: $timePicked, isTimePicked: $isTimePicked)
                            .presentationDetents([.fraction(0.45)])
                    }
                }
                
                if isSearch {
                    //                getDirections()
                    //                getWalkingDirections()
                    DraggableSheet(
                        routes: [Route.all[0]],
                        fromHour: 6,
                        fromMinute: 0
                    )
                    .edgesIgnoringSafeArea(.bottom)
                    .transition(.move(edge: .bottom))
                    //                .onAppear {
                    //                    getDirections()
                    //                    getWalkingDirections()
                    //                }
                }
                if showLocationSearchView {
                    LocationSearchView(
                        isTimePicked: $isTimePicked,
                        showSearchLocationView: $showLocationSearchView,
                        isSearch: $isSearch) {
                            getWalkingDirections()
                            getDirections()
                            locationViewModel.searchDirection()
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//
//
//                                }
                            
                            
                        
                            
//                            print("loc : \(loc)")
                            
                            //                            route = locationViewModel.route
                            //                            routePolylines = locationViewModel.routePolylines
                            //                            show
                            
                            
                        }
                        .environmentObject(locationViewModel)
                        .onDisappear {
                            getDirections()
                            getWalkingDirections()
                        }
//                        .onAppear {
//                                                            if let routeDetails = locationViewModel.generateRoute() {
//                                                                let startBusStop = routeDetails.startBusStop
//                                                                let endBusStop = routeDetails.endBusStop
//                                                                let routes = routeDetails.routes
//                            
//                                                                // Generate the bus stops the user will pass through based on the first matching route
//                                                                if let busStopsOnRoute = locationViewModel.generateBusStops(from: startBusStop, to: endBusStop, routes: routes) {
//                                                                    // Print out the bus stops
//                                                                    for busStop in busStopsOnRoute {
//                                                                        print("Bus stop: \(busStop.name)")
//                                                                    }
//                                                                } else {
//                            
//                            
//                                                                    // Generate paths with possible transfers considering transit bus stops
//                                                                    let pathsWithTransfers = locationViewModel.generatePathsWithTransfers(startBusStop: startBusStop, endBusStop: endBusStop, routes: routes)
//                            
//                                                                    // Print out the possible paths
//                                                                    for (index, path) in pathsWithTransfers.enumerated() {
//                                                                        print("Path \(index + 1):")
//                                                                        for busStop in path {
//                                                                            print("  \(busStop.name)")
//                                                                        }
//                                                                    }
//                                                                }
//                                                            } else {
//                            
//                                                                print("Could not generate a route.")
//                                                            }
//                        }
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
        print("start getDirection()")
        Task {
            let waypoints: [CLLocationCoordinate2D] = [
                locationViewModel.selectedStartCoordinate,
                locationViewModel.selectedEndCoordinate
            ]
            
            startingCoordinate = locationViewModel.selectedStartCoordinate
            destinationCoordiante = locationViewModel.selectedEndCoordinate
            
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
            
            if let routeDetails = generateRoute(from: startingCoordinate, to: destinationCoordiante) {
                let startBusStop = routeDetails.startBusStop
                let endBusStop = routeDetails.endBusStop
                let routes = routeDetails.routes
                
                
                // Generate the bus stops the user will pass through based on the first matching route
                if let busStopsOnRoute = locationViewModel.generateBusStops(from: startBusStop, to: endBusStop, routes: routes) {
                    // Print out the bus stops
                    for busStop in busStopsOnRoute {
                        print("Bus stop: \(busStop.name)")
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
            } else {
                
                print("Could not generate a route.")
            }
            
        }
        
        
    }
    //
    func getWalkingDirections(/*to destination: CLLocationCoordinate2D*/) {
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
    //
    //    func findNearestBusStop(from userLocation: CLLocationCoordinate2D) -> BusStop? {
    //        let userLocationCLLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
    //
    //        // Find the nearest bus stop by calculating the distance to each bus stop
    //        var nearestBusStop: BusStop?
    //        var shortestDistance: CLLocationDistance = CLLocationDistanceMax
    //
    //        for busStop in BusStop.all {
    //            let busStopLocation = CLLocation(latitude: busStop.latitude, longitude: busStop.longitude)
    //            let distance = userLocationCLLocation.distance(from: busStopLocation)
    //
    //            if distance < shortestDistance {
    //                shortestDistance = distance
    //                nearestBusStop = busStop
    //            }
    //        }
    //
    //        return nearestBusStop
    //    }
    //
    //    func findRoutes(for busStop: BusStop) -> [Route] {
    //        var matchingRoutes: [Route] = []
    //
    //        for route in Route.all {
    //            if route.busStops.contains(busStop.id) {
    //                matchingRoutes.append(route)
    //            }
    //        }
    //
    //        return matchingRoutes
    //    }
    //
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
    //    func generateBusStops(from startBusStop: BusStop, to endBusStop: BusStop, routes: [Route]) -> [BusStop]? {
    //        // Find the first route that has both start and end bus stops
    //        for route in routes {
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
    //
    //
    //                return busStopsOnRoute
    //            }
    //        }
    //
    //        // Return nil if no matching route was found
    //        return nil
    //    }
    //
    //    func generatePathsWithTransfers(startBusStop: BusStop, endBusStop: BusStop, routes: [Route]) -> [[BusStop]] {
    //        var possiblePaths: [[BusStop]] = []
    //
    //        // Find transit bus stops (those that appear in multiple routes)
    //        let transitBusStops = BusStop.all.filter { $0.isTransitStop }
    //
    //        // Iterate through routes to find possible paths with transfers
    //        for route in routes {
    //            // Check if the route contains both start and end bus stops
    //            if let startIndex = route.busStops.firstIndex(of: startBusStop.id),
    //               let endIndex = route.busStops.firstIndex(of: endBusStop.id),
    //               startIndex <= endIndex {
    //
    //                // Generate path for this route without transferring
    //                let busStopsOnRoute = Array(route.busStops[startIndex...endIndex]).compactMap { busStopID in
    //                    return BusStop.all.first { $0.id == busStopID }
    //                }
    //                possiblePaths.append(busStopsOnRoute)
    //
    //                // Now, check for paths with transfers
    //                for transitBusStop in transitBusStops {
    //                    // Check if the transit bus stop exists in this route
    //                    if let transferIndex = route.busStops.firstIndex(of: transitBusStop.id),
    //                       transferIndex > startIndex {
    //
    //                        // Split the route at the transfer point and create a path with transfer
    //                        let firstPart = Array(route.busStops[startIndex...transferIndex])
    //                        let secondPart = Array(route.busStops[transferIndex...endIndex])
    //
    //                        let firstPath = firstPart.compactMap { busStopID in
    //                            return BusStop.all.first { $0.id == busStopID }
    //                        }
    //                        let secondPath = secondPart.compactMap { busStopID in
    //                            return BusStop.all.first { $0.id == busStopID }
    //                        }
    //
    //                        possiblePaths.append(firstPath + secondPath)
    //                    }
    //                }
    //            }
    //        }
    //
    //        return possiblePaths
    //    }
    
    /**END OF COPY**/
    
    //    // Returns the schedule for a bus stop (for simplicity, assume the bus stop is indexed)
    //    func getSchedule(for busStopID: String) -> [ScheduleDetail] {
    //        // Fetch the schedule for this bus stop from the route's schedule
    //        return self.schedule
    //            .flatMap { Schedule.getSchedules(by: [$0]) }
    //            .flatMap { $0.scheduleDetail }
    //            .filter { $0.busStop == busStopID }
    //    }
    
    //    func generatePathsWithTransfers(
    //        startBusStop: BusStop,
    //        endBusStop: BusStop,
    //        routes: [Route],
    //        startHour: Int,
    //        startMinute: Int
    //    ) -> [[BusStop]] {
    //        var possiblePaths: [[BusStop]] = []
    //
    //        // Find transit bus stops (those that appear in multiple routes)
    //        let transitBusStops = BusStop.all.filter { $0.isTransitStop }
    //
    //        // Convert the start time to a `Date` object for comparison
    //        let startTime = Calendar.current.date(bySettingHour: startHour, minute: startMinute, second: 0, of: Date())!
    //
    //        // Iterate through routes to find possible paths with transfers
    //        for route in routes {
    //            // Check if the route contains both start and end bus stops
    //            if let startIndex = route.busStops.firstIndex(of: startBusStop.id),
    //               let endIndex = route.busStops.firstIndex(of: endBusStop.id),
    //               startIndex <= endIndex {
    //
    //                // Generate path for this route without transferring
    //                let busStopsOnRoute = Array(route.busStops[startIndex...endIndex]).compactMap { busStopID in
    //                    return BusStop.all.first { $0.id == busStopID }
    //                }
    //
    //                // Check if the user can catch the first bus on this route at the start bus stop
    //                let schedule = route.getSchedule(for: startBusStop.id)
    //                let firstDeparture = schedule.first { $0.time >= startTime }
    //
    //                if let firstDepartureTime = firstDeparture?.time {
    //                    // User can catch the bus, add the path
    //                    possiblePaths.append(busStopsOnRoute)
    //                }
    //
    //                // Now, check for paths with transfers at transit bus stops
    //                for transitBusStop in transitBusStops {
    //                    // Check if the transit bus stop exists in this route and can be reached in time
    //                    if let transferIndex = route.busStops.firstIndex(of: transitBusStop.id),
    //                       transferIndex > startIndex {
    //
    //                        // Generate a path before and after the transfer
    //                        let firstPart = Array(route.busStops[startIndex...transferIndex])
    //                        let secondPart = Array(route.busStops[transferIndex...endIndex])
    //
    //                        let firstPath = firstPart.compactMap { busStopID in
    //                            return BusStop.all.first { $0.id == busStopID }
    //                        }
    //                        let secondPath = secondPart.compactMap { busStopID in
    //                            return BusStop.all.first { $0.id == busStopID }
    //                        }
    //
    //                        // Check the schedule for the transfer bus stop to ensure the user can catch the second part
    //                        let transferSchedule = route.getSchedule(for: transitBusStop.id)
    //                        let transferDeparture = transferSchedule.first { $0.time >= firstDepartureTime }
    //
    //                        if let transferDepartureTime = transferDeparture?.time {
    //                            // User can transfer, add the path
    //                            possiblePaths.append(firstPath + secondPath)
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //
    //        return possiblePaths
    //    }
    
    
    
    
    //    func generateBusStops(from startBusStop: BusStop, to endBusStop: BusStop, routes: [Route]) -> [BusStop] {
    //        var selectedBusStops: [BusStop] = []
    //
    //        // Iterate over each matching route
    //        for route in routes {
    //            // Find the indices of the start and end bus stops in the route's busStops array
    //            if let startIndex = route.busStops.firstIndex(of: startBusStop.id),
    //               let endIndex = route.busStops.firstIndex(of: endBusStop.id) {
    //
    //                // Make sure that start index comes before the end index (order matters)
    //                if startIndex <= endIndex {
    //                    // Get the subarray of bus stops from start to end
    //                    let busStopIDs = Array(route.busStops[startIndex...endIndex])
    //
    //                    // Convert bus stop IDs to BusStop objects
    //                    for busStopID in busStopIDs {
    //                        if let busStop = BusStop.all.first(where: { $0.id == busStopID }) {
    //                            selectedBusStops.append(busStop)
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        print("generate bus stops")
    //
    //        return selectedBusStops
    //    }
    
}


struct DraggableSheet: View {
    let routes: [Route]
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

//#Preview {
//    DiscoverView()
//}
//

