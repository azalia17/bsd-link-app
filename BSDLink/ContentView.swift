//
//  ContentView.swift
//  BSDLink
//
//  Created by Azalia Amanda on 19/03/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some View {
        TabBar()
            .environmentObject(locationViewModel)
    }
}

//#Preview {
//    ContentView()
//}

