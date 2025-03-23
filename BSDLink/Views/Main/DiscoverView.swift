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
    
    
    var body: some View {
        Map(initialPosition: cameraPosition) {
            Marker("Istiqlal", systemImage: "moon.fill", coordinate: .bbb)
                            .tint(.green)
            
            Annotation("Istiqlal", coordinate: .istiqlal, anchor: .bottom) {
                Image(systemName: "moon.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(7)
                    .background(.orange.gradient, in: .circle)
//                    .contextMenu {
//                        Button("Get Directions", systemImage: "arrow.turn.down.right") {
//                            
//                        }
//                    }
            }
            
            UserAnnotation()
            ForEach(routePolylines, id: \.self) { polyline in
                MapPolyline(polyline)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .tint(.pink)
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
            HStack {
                GroupBox {
                    HStack{
                        VStack {
                            Label("From", systemImage: "mappin.and.ellipse")
                            Spacer()
                            Label("To", systemImage: "flag.filled.and.flag.crossed")
                        }
                        VStack {
                            TextField("", text: $destinationPoint)
                            Spacer()
                            Divider()
                            Spacer()
                            TextField("", text: $startingPoint)
                                
                        }
                           
                        Spacer()
                        Divider()
                        Spacer()
                        
                        Button("Search", systemImage: "rectangle.2.swap") {
                            
                        }
                        
                        .frame(height: 35, alignment: .center)
    //                    .background(.white)
                        .labelStyle(.iconOnly)
//                        .buttonStyle(.borderedProminent)
                        
//                        .tint(.white)
                        .foregroundColor(.black)
//                        .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
                        
                    }
                        .frame(height: 75)
    //                    Toggle(isOn: "$userAgreed") {
    //                        Text("I agree to the above terms")
    //                    }
                    }
                
//                .groupBoxStyle(DefaultGroupBoxStyle())
                
    //            .frame(width: .)
    //            .foregroundColor(.white)
    //            .background(.white)
//                .tint(.white)
                
                .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
    //            TextField("From", text: $startingPoint)
    //                .safeAreaPadding()
    //                .background(.white)
                
                VStack {
                    Button("Search", systemImage: "magnifyingglass") {
                        getDirections(to: .istiqlal)
                    }
                    
                    .frame(height: 35, alignment: .center)
//                    .background(.white)
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
            .frame(height: 100)
            .safeAreaPadding()
//            .scaledToFit()
        }
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
    
    func getDirections(to destination: CLLocationCoordinate2D) {
        Task {
            guard let userLocation = await getUserLocation() else { return }
            
            let waypoints: [CLLocationCoordinate2D] = [
                userLocation,
                CLLocationCoordinate2D(latitude: -6.270166, longitude: 106.821375),
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
}

#Preview {
    DiscoverView()
}

extension CLLocationCoordinate2D {
    static let istiqlal = CLLocationCoordinate2D(latitude: -6.170166, longitude: 106.831375)
    static let bbb = CLLocationCoordinate2D(latitude: -6.270166, longitude: 106.821375)

}
