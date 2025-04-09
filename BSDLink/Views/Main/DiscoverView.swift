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

    @State var busStopData: [String : [String]] = [:]
    
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
                    fromMinute: 0,
                    busStopData: busStopData
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
                
                busStopData = getScheduleForInterestedStops(route: bestRoutes[0], schedules: Schedule.getSchedules(by: bestRoutes[0].schedule), interestedStops: locationViewModel.busStopsGenerated.map { $0.busStopId })
                
//                print()

                
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
    
//    func getScheduleForInterestedStops(route: Route, schedules: [Schedule], interestedStops: [String]) -> [String] {
//        var result: [String] = []
//        
//        // Iterate through each schedule
//        for schedule in schedules {
//            // Check the schedule details for the interested bus stops
//            for stop in interestedStops {
//                // Find the schedule detail for the bus stop
//                if let detail = schedule.scheduleDetail.first(where: { $0.contains(stop) }) {
//                    result.append(detail)
//                }
//            }
//        }
//        
//        return result
//    }
    
//    func getScheduleForInterestedStops(route: Route, schedules: [Schedule], interestedStops: [String]) -> [String: [String]] {
//        var result: [String: [String]] = [:]
//        
//        // Iterate through each schedule
//        for schedule in schedules {
//            // Check the schedule details for the interested bus stops
//            for stop in interestedStops {
//                // Filter schedule details for the current stop
//                let details = schedule.scheduleDetail.filter { $0.contains(stop) }
//                
//                // If there are matching details, sort them by the number at the end of the string
//                if !details.isEmpty {
//                    // Extract the number from each schedule detail (after the last underscore)
//                    let sortedDetails = details.sorted { (first, second) -> Bool in
//                        // Extract the number after the last underscore
//                        let firstNumber = extractNumber(from: first)
//                        let secondNumber = extractNumber(from: second)
//                        return firstNumber < secondNumber
//                    }
//                    
//                    // Add sorted details to the result
//                    if result[stop] != nil {
//                        result[stop]?.append(contentsOf: sortedDetails)
//                    } else {
//                        result[stop] = sortedDetails
//                    }
//                }
//            }
//        }
//        
//        return result
//    }
//
//    // Helper function to extract the number after the last underscore
//    func extractNumber(from string: String) -> Int {
//        let components = string.split(separator: "_")
//        if let numberString = components.last, let number = Int(numberString) {
//            return number
//        }
//        return 0  // Default to 0 if the number cannot be extracted
//    }
    
    func getScheduleForInterestedStops(route: Route, schedules: [Schedule], interestedStops: [String]) -> [String: [String]] {
        var result: [String: [String]] = [:]
        
        // Iterate through each schedule
        for schedule in schedules {
            // Check the schedule details for the interested bus stops
            for stop in interestedStops {
                // Filter schedule details for the current stop
                var details = schedule.scheduleDetail.filter { $0.contains(stop) }
                
                // If there are matching details, merge them into the result
                if !details.isEmpty {
                    // If the bus stop is already in the result, append the details
                    if result[stop] != nil {
                        result[stop]?.append(contentsOf: details)
                    } else {
                        // Otherwise, create a new entry for the bus stop
                        result[stop] = details
                    }
                }
            }
        }
        
        // Now, for each bus stop, sort the schedule details by the number at the end
        for (stop, details) in result {
            // Sort the details by the number after the last underscore
            result[stop] = details.sorted { (first, second) -> Bool in
                let firstNumber = extractNumber(from: first)
                let secondNumber = extractNumber(from: second)
                return firstNumber < secondNumber
            }
        }
        
        return result
    }

    // Helper function to extract the number from the schedule detail
    func extractNumber(from string: String) -> Int {
        let components = string.split(separator: "_")
        if let numberString = components.last, let number = Int(numberString) {
            return number
        }
        return 0  // Default to 0 if the number cannot be extracted
    }




    
//    func getRoutee(by id: String, from routes: [Route]) -> Route? {
//        return routes.first(where: { $0.id == id })
//    }
//    
//    // Function to get the schedule based on the bus associated with the route
//    func getSchedulee(for route: Route, from schedules: [Schedule]) -> Schedule? {
//        return schedules.first(where: { $0.bus == route.bus.first })  // Assume first bus for simplicity
//    }
//    
//    // Function to get schedule details and sort by bus stop index
//    func getOrderedScheduleDetailss(for route: Route, schedule: Schedule) -> [ScheduleDetail]? {
//        var orderedDetails: [ScheduleDetail] = []
//
//        // For each bus stop in the route, find the corresponding ScheduleDetail
//        for (index, busStop) in route.busStops.enumerated() {
//            if let scheduleDetail = ScheduleDetail.getScheduleDetail(by: schedule.first.scheduleDetail)(where: { $0.busStop == busStop }) {
//                var updatedScheduleDetail = scheduleDetail
//                updatedScheduleDetail.index = index  // Set the index based on the bus stop position
//                orderedDetails.append(updatedScheduleDetail)
//            }
//        }
//
//        // Sort details by index (to ensure correct order)
//        orderedDetails.sort { $0.index < $1.index }
//
//        return orderedDetails
//    }


    
//    func getScheduleDetail(routeId: String) {
        // Example route ID (you know the route already)
//        let routeId = "route_4"

        // Example list of routes and schedules
//        let routes: [Route] = Route.all
//        let schedules: [Schedule] = Schedule.all
//
//        // Step 1: Get the route by ID
//        if let route = getRoutee(by: routeId, from: routes) {
//            print("Found route: \(route.name)")
//            
//            // Step 2: Get the corresponding schedule for the route
//            if let schedule = getSchedulee(for: route, from: schedules) {
//                print("Found schedule for route: \(schedule.id)")
//                
//                // Step 3: Get ordered schedule details based on bus stops
//                if let orderedDetails = getOrderedScheduleDetailss(for: route, schedule: schedule) {
//                    // Step 4: Print out the ordered schedule details
//                    for detail in orderedDetails {
//                        print("Bus Stop: \(detail.busStop), Time: \(detail.time)")
//                    }
//                }
//            } else {
//                print("No schedule found for route.")
//            }
//        } else {
//            print("Route not found.")
//        }
        // Example route ID (you already know the route)
//        let routeId = "route_4"
//
//        // Example list of routes and schedules (populated as per your data)
//        let routes: [Route] = [ /* Your route data here */ ]
//        let schedules: [Schedule] = [ /* Your schedule data here */ ]
//
//        // Step 1: Get the route by ID
//        if let route = getRoute(by: routeId, from: routes) {
//            print("Found route: \(route.name)")
//            
//            // Step 2: Get the corresponding schedule for the route
//            if let schedule = getSchedule(for: route, from: schedules) {
//                print("Found schedule for route: \(schedule.id)")
//                
//                // Step 3: Get ordered schedule details based on bus stops
//                if let orderedDetails = getOrderedScheduleDetails(for: route, schedule: schedule) {
//                    // Step 4: Print out the ordered schedule details
//                    for detail in orderedDetails {
//                        // Print schedule details in order of bus stops
//                        print("Bus Stop: \(detail.busStop), Time: \(detail.time)")
//                    }
//                }
//            } else {
//                print("No schedule found for route.")
//            }
//        } else {
//            print("Route not found.")
//        }
//
//
//    }
    
}


struct DraggableSheet: View {
    var routes: [Route]
    let fromHour: Int
    let fromMinute: Int
    var busStopData: [String : [String]]
    
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
                busStopData: busStopData,
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
