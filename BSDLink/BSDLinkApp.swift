//
//  BSDLinkApp.swift
//  BSDLink
//
//  Created by Azalia Amanda on 19/03/25.
//

import SwiftUI

@main
struct BSDLinkApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel()

//    init() {
//        _locationViewModel = StateObject(wrappedValue: LocationSearchViewModel())
//    }
    
    var body: some Scene {
        WindowGroup {
//            TabBar()
//            Text("Aaa")
            ContentView()
                .environmentObject(locationViewModel)
        }
    }
}
