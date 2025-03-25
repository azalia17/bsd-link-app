//
//  DiscoverView.swift
//  BSDLink
//
//  Created by Azalia Amanda on 23/03/25.
//

import SwiftUI
import MapKit

struct DiscoverView: View {
    let cameraPosition: MapCameraPosition = .region(.init(center: .init(latitude: -6.200000, longitude: 106.816666), latitudinalMeters: 13000, longitudinalMeters: 13000))
    
    let locationManager = CLLocationManager()
    @State private var routePolylines: [MKPolyline] = []
    @State private var startingPoint: String = ""
    @State private var destinationPoint: String = ""
    @State private var showResultRoute = false
    @State private var route: MKRoute?
    
    
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
                HStack {
                    GroupBox {
                        HStack{
                            VStack {
                                Label("From", systemImage: "mappin.and.ellipse")
                                    .opacity(0.5)
                                Spacer()
                                Label("To", systemImage: "flag.filled.and.flag.crossed")
                                    .opacity(0.5)
                            }
                            VStack {
                                TextField("", text: $startingPoint)
                                Spacer()
                                Divider()
                                Spacer()
                                TextField("", text: $destinationPoint)
                            }
                            
                            Spacer()
                            Divider()
                            Spacer()
                            
                            Button("Search", systemImage: "rectangle.2.swap") {
                            }
                            .frame(height: 35, alignment: .center)
                            .labelStyle(.iconOnly)
                            .foregroundColor(.black)
                            
                        }
                        .frame(height: 75)
                    }
                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
                    
                    VStack {
                        Button("Search", systemImage: "magnifyingglass") {
                            getWalkingDirections(to: .bbb)
                            getDirections()
                        }
                        
                        .frame(height: 35, alignment: .center)
                        .labelStyle(.iconOnly)
                        .buttonStyle(.borderedProminent)
                        
                        .tint(.white)
                        .foregroundColor(.black)
                        .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
                        
                        
                        
                        Spacer()
                        
                        Button("Filter", systemImage: "slider.vertical.3") {
                            
                        }
                        .labelStyle(.iconOnly)
                        .buttonStyle(.borderedProminent)
                        .tint(.white)
                        .foregroundColor(.black)
                        .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
                    }
                }
                
                ScrollView {
                    HStack {
                        ForEach(1..<3) { index in
                            Button ("Route \(index) - \(index + 1)") {
                                startingPoint = "Route \(index)"
                                destinationPoint = "Route \(index + 1)"
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.white)
                            .foregroundColor(.black)
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 7, y: 8)
                        }
                    }
                }
            }
            .frame(height: 150)
            .safeAreaPadding()
        }
        .sheet(isPresented: $showResultRoute, content: {
            Text("This is detail")
        })
        

    }
    
    func getUserLocation() async -> CLLocationCoordinate2D? {
        let updates = CLLocationUpdate.liveUpdates()
        
        do {
            let update = try await updates.first { $0.location?.coordinate != nil }
            return update?.location?.coordinate
        } catch {
            print("Cannot get user location")
            return nil
        }
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

extension CLLocationCoordinate2D {
    static let istiqlal = CLLocationCoordinate2D(latitude: -6.170166, longitude: 106.831375)
    static let bbb = CLLocationCoordinate2D(latitude: -6.270166, longitude: 106.821375)
    static let ccc = CLLocationCoordinate2D(latitude: -6.20166, longitude: 106.825375)
}
