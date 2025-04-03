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
                
                if showOneTimeSearchInfo {
                    ZStack (alignment: .topTrailing){
                        Text("Try searching the name of a bus stop to know which routes pass by it.")
                            .multilineTextAlignment(.center)
                            .padding(.top, 20)
                        
                        Button(action: {
                            showOneTimeSearchInfo = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14))
                                .padding(1)
                        }
                        .foregroundStyle(.gray)
                        
                        
                    }
                    .padding()
                    .frame(width: 355, height: 100, alignment: .center)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                }
                
                //Buat nampilin list rute yang disearch
                VStack {
                    List {
                        ForEach(filteredRoutes, id: \.id) { route in
                            RouteTile(routeName: route.name, stops: route.busStops.count)
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
                    SearchRoutesInfo(isShow: $showSearchInfo)
                        .presentationDetents([.fraction(0.2)])
                }
                
            }
            .searchable(text: $searchTerm)
        }
    }
}



#Preview {
    RouteListView()
}


