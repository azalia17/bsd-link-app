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
    
    @State private var startingCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    @State private var destinationCoordiante: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    @State private var showResultRoute = false
    @State private var route: MKRoute?
    
    @State private var isSearch: Bool = false
    @State private var showTimePicker: Bool = false
    @State private var showPopover: Bool = false
    @State private var timePicked = Date() /*Calendar.current.dateComponents([.hour, .minute, .second], from: Date.now)*/
    @State private var isTimePicked: Bool = false
    
    //    init() {
    //        Task {
    //            await getUserLocation()
    //        }
    //    }
    
    
    
    //    Task {
    //        userLocation = await getUserLocation() else { return }
    //    }
    
    var body: some View {
        
        Map(initialPosition: cameraPosition) {
            Marker("Halte A", systemImage: "bus", coordinate: .bbb)
                .tint(.orange.gradient)
            
            Marker("Halte B", systemImage: "bus", coordinate: .ccc)
                .tint(.orange.gradient)
            
            Annotation("Istiqlal", coordinate: .istiqlal, anchor: .bottom) {
                Image(systemName: "moon.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .padding(7)
                    .background(.orange.gradient, in: .circle)
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
                            getWalkingDirections(to: .bbb)
                            getDirections()
                            isSearch = true
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
                        isTimePicked: $isTimePicked
                    )
                    
                    QuickSearch(
                        startingPoint: $startingPoint,
                        destinationPoint: $destinationPoint
                    )
                } else {
                    HStack{
                        Text(startingPoint)
                        Image(systemName: "arrow.forward")
                        Text(destinationPoint)
                        
                        Spacer()
                        
                        Image(systemName: "ellipsis.circle")
                            .contextMenu{
                                Button("Edit", systemImage: "magnifyingglass") {
                                    isSearch = false
                                }
                                Button("Filter", systemImage: isTimePicked ? "clock.badge.checkmark" : "clock") {
                                    showTimePicker = true
                                }
                                .foregroundColor(isTimePicked ? .blue : .black)
                                Button("Reverse", systemImage: "rectangle.2.swap") {
                                    swapDirections(start: startingPoint, destination: destinationPoint)
                                    getWalkingDirections(to: .bbb)
                                    getDirections()
                                    isSearch = true
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(.white)
                            .frame(maxWidth: .infinity)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    )
                }
                Spacer()
            }
            .safeAreaPadding()
            .frame(height: 150)
            
            
        }
        .sheet(isPresented: $showResultRoute, content: {
            Text("This is detail")
        })
        .sheet(isPresented: $showTimePicker) {
            TimePicker(showTimePicker: $showTimePicker, timePicked: $timePicked, isTimePicked: $isTimePicked)
                .presentationDetents([.fraction(0.45)])
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
                .bbb,
                .ccc,
                .istiqlal
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
    
    func getWalkingDirections(to destination: CLLocationCoordinate2D) {
        Task {
            guard let userLocation = await getUserLocation() else { return }
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: .init(coordinate: userLocation))
            request.destination = MKMapItem(placemark: .init(coordinate: destination))
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

#Preview {
    DiscoverView()
}


