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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationViewModel)
        }
    }
}
