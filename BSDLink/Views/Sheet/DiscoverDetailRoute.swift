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
            if (routes.count < 1) {
                Spacer()
                Text("No routes found. Try other places")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .contentShape(Rectangle())
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            } else if (routes.count > 1) {
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
                Text("Route \(routes[0].routeNumber) - Route \(routes[routes.count - 1].routeNumber)")
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
                
                
                BusTypeCard(busList: Bus.all)
                    .padding(.vertical, 12)
                
                Text("Bus Stops")
                    .font(.title2)
                    .bold()
                
                Text("Schedule show: 13.00 - 14.00")
                    .font(.caption)
                    .foregroundColor(.gray)
                VStack(spacing: 0) {
                    ForEach(route.busStops.indices, id: \.self) { index in
//                        let busStopName : String = route.busStops[index]
//                        let isLast : Bool = index == route.busStops.count - 1
                        
                        ItemExpandable(
                            busStop: BusStop.getSingleStop(by: route.busStops[index]),
                            fromHour: 7,
                            fromMinute: 0,
                            index: index,
                            isLastItem: index == route.busStops.count - 1,
                            contentExpanded: {
                                ScheduleGrid(schedules: [])
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
                    BusTypeCard(busList: Bus.getBusses(by: route.bus))
                    
                    Divider()
                        .padding(.vertical)
                    
                    Text("Bus Stops")
                        .font(.title2)
                        .bold()
                    Text("Schedule show: 13.00 - 14.00")
                        .font(.caption)
                        .foregroundColor(.gray)
                    VStack(spacing: 0) {
//                        let mappedBusStops = route.busStops.compactMap { BusStop.getSingleStop(by: $0) }

//                        ForEach(Array(route.busStops.enumerated()), id: \.element.id) { index, busStop in
//                            ItemExpandable(
//                                busStop: busStop,
//                                fromHour: 6,
//                                fromMinute: 0,
//                                index: index,
//                                isLastItem: index == route.busStops.count - 1,
//                                contentExpanded: {
//                                    ScheduleGrid(schedules: [])
//                                },
//                                isShowPreviewSchedule: true
//                            )
//                        }
                        ForEach(route.busStops.indices, id: \.self) { index in
//                            let busStopName : String = route.busStops[index]
//                            let isLast : Bool = index == route.busStops.count - 1
                            
                            ItemExpandable(
                                busStop: BusStop.getSingleStop(by: route.busStops[0]),
                                fromHour: 6,
                                fromMinute: 0,
                                index: index,
                                isLastItem: false,
                                contentExpanded: {
                                    ScheduleGrid(schedules: [])
                                },
                                isShowPreviewSchedule: true
                            )
                        }
                        
//                        ForEach(0..<3) { index in
//                            ItemExpandable(
//                                busStopName: "Courts Mega Store \(index)",
//                                index: index,
//                                isLastItem: index == 2,
//                                contentExpanded: {
//                                    ScheduleGrid(schedules: [] /*ScheduleTime.all*/, spacing: 1)
//                                        .padding([.top, .trailing])
//                                        .padding(.top)
//                                },
//                                isShowPreviewSchedule: true
//                            )
//                        }
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
    DiscoverDetailRoute(routes: [Route.all[0], Route.all[0]])
    //            DiscoverDetailRoute(routes: [Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: []), Route(name: "bbb", routeNumber: "Route 2", busStops: [], bus: []), Route(name: "bbb", routeNumber: "Route 3", busStops: [], bus: [])])
    //    DiscoverDetailRoute(routes: [Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: [])])
}

//#Preview {
//    //            DiscoverDetailRoute(routes: [Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: []), Route(name: "bbb", routeNumber: "Route 2", busStops: [], bus: []), Route(name: "bbb", routeNumber: "Route 3", busStops: [], bus: [])])
//    //    DiscoverDetailRoute(routes: [Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: [])])
//}
