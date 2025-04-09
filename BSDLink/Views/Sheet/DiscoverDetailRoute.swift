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
    var busStopData: [String: [String]]
    let fromHour: Int
    let fromMinute: Int
    @State var showRouteInfo : Bool = false
    
    var body: some View {
        
        VStack {
            Capsule()
                .foregroundColor(.gray.opacity(0.4))
                .frame(width: 48, height: 6)
                .padding(.bottom, 12)
                .padding(.top, 12)
            if (routes.count < 1) {
                Spacer()
                Text("Oh no! Something went wrong. Please go back to discover view and try to search again.\n\nSorry!!")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .contentShape(Rectangle())
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            } else if (routes.count > 1) {
                DiscoverDetailTransitRoute(
                    routes: routes,
                    fromHour: fromHour,
                    fromMinute: fromMinute,
                    showSearchInfo: $showRouteInfo
                )
            } else {
                DiscoverDetailSingleRoute(
                    route: routes[0],
                    fromHour: fromHour,
                    fromMinute: fromMinute,
                    showSearchInfo: $showRouteInfo,
                    busStopData: busStopData
                )
            }
        }
        .padding([.horizontal])
        .background(.white)
        .cornerRadius(12)
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showRouteInfo) {
            RouteInfo(routes: routes, isShow: $showRouteInfo)
        }
    }
}

struct DiscoverDetailTransitRoute: View {
    let routes: [Route]
    let fromHour: Int
    let fromMinute: Int
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
                        DiscoverDetailTransitRouteContent(
                            route: route,
                            fromHour: fromHour,
                            fromMinute: fromMinute
                        )
                        Divider()
                            .padding(.bottom)
                    }
                }
            }
//            .padding(.bottom, 70)
            .menuIndicator(.hidden)
            .scrollIndicators(.hidden)
        }
    }
}

struct DiscoverDetailTransitRouteContent: View {
    let route: Route
    let fromHour: Int
    let fromMinute: Int
    
    @State private var topExpanded: Bool = true
    
    var body: some View {
        DisclosureGroup(isExpanded: $topExpanded) {
            VStack(alignment: .leading) {
                
                BusTypeCard(busList: Bus.all)
                    .padding(.vertical, 12)
                
                Text("Bus Stops")
                    .font(.title2)
                    .bold()
                
                Text("Schedule show from \(fromHour).\(fromMinute)")
                    .font(.caption)
                    .foregroundColor(.gray)
                VStack(spacing: 0) {
                    ForEach(route.busStops.indices, id: \.self) { index in
                        ScheduleExpandable(
                            index: index,
                            route: route,
                            fromHour: fromHour,
                            fromMinute: fromMinute
                        )
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
    let fromHour: Int
    let fromMinute: Int
    @Binding var showSearchInfo : Bool
    var busStopData: [String: [String]]
    
    public var filteredBusStop: [BusStop] {
        BusStop.getStops(by: Array(busStopData.keys))
    }
    
    
    
//    public var filteredSchedule: [
    
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
                    
                    HStack(alignment: .center){
                        Text("Schedule Type: ")
                            .font(.caption)
                        ScheduleChip(text: "Weekday")
                        ScheduleChip(text: "Weekend", isRegular: false)
                    }.padding(.bottom, 8)
                    
                    //                    Text("Schedule show from \(formatTime(from: timeFrom(fromHour, fromMinute)))")
//                        .font(.caption)
//                        .foregroundColor(.gray)
                    VStack(spacing: 0) {
//
                        ForEach(filteredBusStop.indices, id: \.self) { bus in
//                            busStopData.values
                            let scheduleDetail = ScheduleDetail.getManyScheduleDetails(by: busStopData[filteredBusStop[bus].id] ?? [ScheduleDetail.all[0].id])
                            let schedule : [ScheduleTime] = if route.schedule.count > 1 {
                                scheduleDetail[0].time + scheduleDetail[1].time
                            } else {
                                scheduleDetail[0].time
                            }
//                            
//                            let filteredSchedule : [ScheduleTime] = schedule.flatMap { detail in
//                                detail.time.filter { $0.time >= fromHour && $0.time < fromHour + 20 }
//                            }.sorted { $0.time < $1.time }
                            
                            ItemExpandablee(schedule: schedule, route: route, busStop: filteredBusStop[bus], fromHour: fromHour, fromMinute: fromMinute, scheduleIndex: 0, isFirstItem: bus == 0, isLastItem: filteredBusStop.count - 1 == bus) {
                                ScheduleGrid (
                                    schedules: schedule
//                                    schedules: scheduleDetail[0].time
                                )
                                .padding([.top, .trailing])
                                .padding(.top)
                            }
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
            .filter { $0.busStop == currentBusStopId }
        
        let stopIndex = matchingDetails.indices.contains(index)
        ? matchingDetails[index].index
        : matchingDetails.first?.index ?? 0
        
        ItemExpandable(
            route: route,
            busStop: BusStop.getSingleStop(by: currentBusStopId),
            fromHour: fromHour,
            fromMinute: fromMinute,
            scheduleIndex: stopIndex,
            isFirstItem: index == 0,
            isLastItem: index == route.busStops.count - 1,
            contentExpanded: {
                ScheduleGrid(
                    schedules: Schedule.getScheduleBusStopBasedWithTime(
                        route: route,
                        busStopId: currentBusStopId,
                        index: stopIndex,
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


//#Preview {
//    DiscoverDetailRoute(
//        routes: [Route.all[0], Route.all[0]],
//        fromHour: 6,
//        fromMinute: 0
//    )
//}


struct ItemExpandablee<ExpandedContent: View>: View {
    let schedule: [ScheduleTime]
    let route: Route
    let busStop: BusStop
    let fromHour: Int
    let fromMinute: Int
    let scheduleIndex: Int
    let isFirstItem: Bool
    let isLastItem: Bool  // Pass info if this is the last item
    let contentExpanded: () -> ExpandedContent
    
    @State private var isExpanded: Bool = true
    @State private var expandedHeight: CGFloat = 0  // Store the expanded height
    

    
    var isShowPreviewSchedule: Bool = true
    
    
    var body: some View {
        let corner: UIRectCorner = if isLastItem {[.bottomLeft, .bottomRight]} else if isFirstItem {[.topLeft, .topRight]} else {[]}
        HStack(alignment: .top) {
            VStack {
                Rectangle()
                    .fill(!isFirstItem ? Color.blue : .gray.opacity(0.0))
                    .frame(width: 3, height: 32) // Connect to previous item
                    .overlay(content: {
                        Rectangle()
                            .fill(!isFirstItem ? Color.blue : .gray.opacity(0.0))
                            .frame(width: 3, height: 32)
                            .offset(y: 20)
                    })
                
                
                Rectangle()
                    .fill(isLastItem ? .gray.opacity(0.0) : Color.blue)
                    .frame(width: 3, height: 40)
                    .offset(y: 24)
                    .overlay(
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .overlay(content: {
                                Image(systemName:"circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.white.opacity(0.8))
                            })
                    )
                
                Rectangle()
                    .fill(isLastItem ? .gray.opacity(0.0) : Color.blue)
                    .frame(width: 3, height: isExpanded ? expandedHeight : 32)
            }
            .padding(.leading, 4)
            
            ExpandableContentTypee(
                route: route,
                busStop: busStop,
                scheduleIndex: scheduleIndex,
                fromHour: fromHour,
                fromMinute: fromMinute,
                contentExpanded: contentExpanded,
                schedule: schedule,
                isExpanded: $isExpanded,
                expandedHeight: $expandedHeight,
                isShowPreviewSchedule: isShowPreviewSchedule,
                isFirstItem: isFirstItem
            )
        }
        .padding(.leading, 12)
        .frame(alignment: .leading)
        .background(Color.gray.opacity(0.1))
        //        .padding(.bottom, 1)
        //        .background(.white)
        .cornerRadius(10, corners: corner)
    }
}

struct ExpandableContentTypee<ExpandedContent: View>: View {
    let route: Route
    var busStop: BusStop
    let scheduleIndex: Int
    let fromHour: Int
    let fromMinute: Int
    let contentExpanded: () -> ExpandedContent
    let schedule: [ScheduleTime]
    
    @Binding var isExpanded: Bool
    @Binding var expandedHeight: CGFloat
    
    var isShowPreviewSchedule: Bool = true
    
    let isFirstItem: Bool
    
    var body: some View {
        VStack{
            if !isFirstItem {
                Divider()
                    .padding(.trailing)
            }
            HStack {
                ImageStack(images: busStop.images)
                    .offset(y: 18)
                VStack(alignment: .leading) {
                    HStack {
                        Text(busStop.name)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                            .offset(y: 18)
                        Spacer()
                        Image(systemName: "chevron.up")
                            .rotationEffect(.degrees(isExpanded ? 0 : 90))
                            .foregroundColor(.blue)
                            .offset(x: -8,y: 18)
                        
                    }
                    
                    if isShowPreviewSchedule && !isExpanded{
                        let sched = schedule
                        let previewSchedule : [ScheduleTime] = if sched.isEmpty {[]} else {[sched[0], sched[1]]}
                        
                        ScheduleGrid(
                            schedules: previewSchedule,
                            isMore: true,
                            spacing: 1
                        )
                        .padding(.top)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .padding(.leading, 8)
            }
            .padding(.leading, 8)
            if isExpanded {
                GeometryReader { geometry in
                    VStack {
                        contentExpanded()
                            .background(GeometryReader { innerGeo in
                                Color.clear
                                    .onAppear {
                                        expandedHeight = innerGeo.size.height + 24
                                    }
                            })
                            .padding(.leading)
                    }
                }
                .frame(height: expandedHeight)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }
            
        }
    }
}
