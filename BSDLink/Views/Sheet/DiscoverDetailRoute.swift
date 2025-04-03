//
//  DiscoverDetailRoute.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import SwiftUI

struct DiscoverDetailRoute: View {
    var routes: [Route]
    @State var showSearchInfo : Bool = false
    
    var body: some View {
        
        VStack {
            Capsule()
                .foregroundColor(.gray.opacity(0.4))
                .frame(width: 48, height: 6)
                .padding(.bottom, 12)
                .padding(.top, 12)
            if (routes.count > 1) {
                DiscoverDetailTransitRoute(routes: routes, showSearchInfo: $showSearchInfo)
            } else {
                DiscoverDetailSingleRoute(route: routes[0], showSearchInfo: $showSearchInfo)
            }
        }
        .padding([.horizontal])
        .background(.white)
        .cornerRadius(12)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showSearchInfo) {
            Text("This space for detail ")
        }
    }
}

struct DiscoverDetailTransitRoute: View {
    var routes: [Route]
    @Binding var showSearchInfo : Bool
    @State private var topExpanded: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(routes[0].routeNumber) - \(routes[routes.count - 1].routeNumber)")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showSearchInfo = true
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(routes) { route in
                        DiscoverDetailTransitRouteContent(route: route)
                        Divider()
                            .padding(.bottom)
                    }
                }
            }
            .padding(.bottom, 100)
            .menuIndicator(.hidden)
            .scrollIndicators(.hidden)
        }
    }
}

struct DiscoverDetailTransitRouteContent: View {
    var route: Route
    @State private var topExpanded: Bool = true
    
    var body: some View {
        DisclosureGroup(isExpanded: $topExpanded) {
            VStack(alignment: .leading) {
                HStack(){
                    Spacer()
                    Text("Space for bus")
                    Spacer()
                }
                .frame(height: 50)
                .background(.gray.opacity(0.5))
                .cornerRadius(8)
                .padding(.bottom)
                .padding(.top, 8)
                
                Text("Bus Stops")
                    .font(.title2)
                    .bold()
                    
                Text("Schedule show: 13.00 - 14.00")
                    .font(.caption)
                    .foregroundColor(.gray)
                VStack(spacing: 0) {
                    ForEach(0..<3) { index in
                        ItemExpandable(
                            busStopName: "Courts Mega Store \(index)",
                            index: index,
                            isLastItem: index == 2,
                            contentExpanded: {
                                ScheduleGrid(schedules: ScheduleTime.all, spacing: 1)
                                    .padding([.top, .trailing])
                                    .padding(.top)
                            },
                            isShowPreviewSchedule: true
                        )
                    }
                }
            }
        } label: {
            Text(route.name)
                .font(.title)
                .fontWeight(.bold)
                
        }
        .foregroundColor(.black)
        
    }
}

struct DiscoverDetailSingleRoute: View {
    var route: Route
    @Binding var showSearchInfo : Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(route.name)
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showSearchInfo = true
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(){
                        Spacer()
                        Text("Space for bus")
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(.gray.opacity(0.5))
                    .cornerRadius(8)
                    
                    
                    Divider()
                        .padding(.vertical)
                    
                    Text("Bus Stops")
                        .font(.title2)
                        .bold()
                    Text("Schedule show: 13.00 - 14.00")
                        .font(.caption)
                        .foregroundColor(.gray)
                    VStack(spacing: 0) {
                        ForEach(0..<3) { index in
                            ItemExpandable(
                                busStopName: "Courts Mega Store \(index)",
                                index: index,
                                isLastItem: index == 2,
                                contentExpanded: {
                                    ScheduleGrid(schedules: ScheduleTime.all, spacing: 1)
                                        .padding([.top, .trailing])
                                        .padding(.top)
                                },
                                isShowPreviewSchedule: true
                            )
                        }
                    }
                }
            }
            .padding(.bottom, 100)
            .menuIndicator(.hidden)
            .scrollIndicators(.hidden)
        }
        
    }
}

#Preview {
//        DiscoverDetailRoute(routes: [Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: []), Route(name: "bbb", routeNumber: "Route 2", busStops: [], bus: []), Route(name: "bbb", routeNumber: "Route 3", busStops: [], bus: [])])
    DiscoverDetailRoute(routes: [Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: [])])
}
