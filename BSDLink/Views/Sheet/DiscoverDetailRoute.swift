//
//  DiscoverDetailRoute.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

/** Complete **/

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
                        ScheduleExpandable(
                            index: index,
                            route: route,
                            fromHour: 7,
                            fromMinute: 0)
                    }
                }
            }
        } label: {
            Text(route.name)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.black.opacity(0.6))
            
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
                        ForEach(route.busStops.indices, id: \.self) { index in
                            ScheduleExpandable( index: index, route: route,
                                                fromHour: 10,
                                                fromMinute: 0)
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
//
struct ScheduleExpandable: View {
    var index : Int
    var route: Route
    let fromHour: Int
    let fromMinute: Int
    
    var body: some View {
        let currentBusStopId = route.busStops[index]
        
        let matchingDetails = route.schedule
            .flatMap { Schedule.getSchedules(by: [$0]) }
            .flatMap { $0.scheduleDetail }
            .map { ScheduleDetail.getScheduleDetail(by: $0) }
            .filter { $0.BusStop == currentBusStopId }
        
//        let stopIndex = matchingDetails.first?.index ?? 0
        let stopIndex = matchingDetails.indices.contains(index)
            ? matchingDetails[index].index
            : matchingDetails.first?.index ?? 0
        
        ItemExpandable(
            busStop: BusStop.getSingleStop(by: currentBusStopId),
            fromHour: fromHour,
            fromMinute: fromMinute,
            scheduleIndex: stopIndex,
            isFirstItem: index == 0,
            isLastItem: index == route.busStops.count - 1,
            contentExpanded: {
                ScheduleGrid(
                    schedules: Schedule.getScheduleBusStopBasedWithTime(
                        busStopId: currentBusStopId,
                        idx: stopIndex,
                        fromHour: fromHour,
                        fromMinute: fromMinute
                    )
                )
                .padding([.top, .trailing])
                .padding(.top)
            },
            isShowPreviewSchedule: true
        )
    }
}


#Preview {
    DiscoverDetailRoute(routes: [Route.all[0], /*Route.all[0]*/])
}
