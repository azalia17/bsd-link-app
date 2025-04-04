//
//  RouteListView.swift
//  BSDLink
//
//  Created by Azalia Amanda on 23/03/25.
//

import SwiftUI

struct RouteListView: View {
    @State private var searchTerm: String = ""
    @State private var showSearchInfo: Bool = false
    @State private var showOneTimeSearchInfo: Bool = true
    
    public var filteredRoutes: [Route] {
        if searchTerm.isEmpty {
            return sampleRoutes
        } else {
            //            return sampleRoutes.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
            // Di atas sisa2 pas awal search rute pake nama rute
            return sampleRoutes.filter { route in
                route.busStops.contains { busStop in busStop.name.localizedCaseInsensitiveContains(searchTerm)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 10) {
                //Logic buat nampilin berapa route yang keliatan
                RouteCount(count: filteredRoutes.count)
                
                //Logic buat one time search info
                if showOneTimeSearchInfo {
                    OneTimeSearchInfo(showOneTimeSearchInfo: $showOneTimeSearchInfo)
                    
                }
                
                //Buat nampilin list rute yang disearch
                VStack {
                    List {
                        ForEach(filteredRoutes, id: \.id) { route in
                            NavigationLink {
                                DetailRouteView(route: route)
                            } label: {
                                RouteTile(routeName: route.name, stops: route.busStops.count)
                            }
                            
                        }
                    }
                }
                .frame(maxWidth: 355, alignment: .init(horizontal: .leading, vertical: .center))
                .cornerRadius(15)
                .navigationTitle(Text("All Routes"))
                
                //Buat nampilin search info
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showSearchInfo = true
                        }) {
                            Image(systemName: "info.circle")
                        }
                    }
                }
                .sheet(isPresented: $showSearchInfo) {
                    SearchInfo(showSearchInfo: $showSearchInfo)
                    
                }
                
            }
            .searchable(text: $searchTerm)
        }
    }
}



#Preview {
    RouteListView()
}

