//
//  TabBar.swift
//  BSDLink
//
//  Created by Azalia Amanda on 23/03/25.
//

import SwiftUI

struct TabBar: View {
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some View {
        TabView {
            DiscoverView()
                .tabItem {
                    Label("Discover", systemImage: "map")
                }
                .environmentObject(locationViewModel)
            
            RouteListView()
                .tabItem {
                    Label("Route List", systemImage: "list.bullet")
                }
        }
    }
}

//#Preview {
//    TabBar()
//}
