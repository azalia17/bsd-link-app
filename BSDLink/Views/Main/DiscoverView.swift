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
                
                if let route {
                    MapPolyline(route)
                        .stroke(.orange, style: StrokeStyle(lineWidth: 3, dash: [6, 3]))
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
                                swapDirections(
                                    start: startingPoint,
                                    destination: destinationPoint
                                )
                            },
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
                    }
                    .environmentObject(locationViewModel)
                    .onDisappear {
                        getDirections()
                        getWalkingDirections()
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
        Task {
            let waypoints: [CLLocationCoordinate2D] = [
                locationViewModel.selectedStartCoordinate,
                locationViewModel.selectedEndCoordinate
            ]
            
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
            
        }
    }
    
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

