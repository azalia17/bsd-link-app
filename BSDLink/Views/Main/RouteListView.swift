//
//  RouteListView.swift
//  BSDLink
//
//  Created by Azalia Amanda on 23/03/25.
//

import SwiftUI

struct RouteListView: View {
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    VStack{
                        Text("Route_Name")
                        Text("X_Stops")
                    }
                    
                }
                
            }
            .navigationTitle(Text("All Routes"))
        }
        .searchable(text: $searchTerm)
    }
}

#Preview {
    RouteListView()
}
