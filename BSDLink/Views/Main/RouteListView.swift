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
            return []
        } else {
            return []
            //            return sampleRoutes.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
            // Di atas sisa2 pas awal search rute pake nama rute
//            return sampleRoutes.filter { route in
//                route.busStops.contains { busStop in busStop.name.localizedCaseInsensitiveContains(searchTerm)
//                }
            }
        }
//    }
    
    var body: some View {
        NavigationStack {
            
            VStack() {
                //Logic buat nampilin berapa route yang keliatan
                RouteCount(count: filteredRoutes.count)
                    .safeAreaPadding(.horizontal)
                
                if showOneTimeSearchInfo {
                    ZStack (alignment: .topTrailing){
                        Text("Try searching the name of a bus stop to know which routes pass by it.")
                            .padding(.trailing, 20)
                            .padding()
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.black.opacity(0.7))
                        
                        
                        Button(action: {
                            showOneTimeSearchInfo = false
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 14))
                                .padding([.top, .trailing])
                        }
                        .foregroundStyle(.black.opacity(0.5))
                        
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .safeAreaPadding(.horizontal)
                    
                }
                
                //Buat nampilin list rute yang disearch
                List(filteredRoutes) { route in
                    NavigationLink {
                        
                    } label : {
                        RouteTile(routeName: route.name, stops: route.busStops.count)
                    }
                    //                        .cornerRadius(15)
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal)
                
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


