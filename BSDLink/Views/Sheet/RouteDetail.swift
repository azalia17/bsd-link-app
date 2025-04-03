//
//  RouteDetail.swift
//  BSDLink
//
//  Created by Azalia Amanda on 03/04/25.
//

import SwiftUI

struct RouteDetail: View {
    var route: Route
    @State var showInfoSheet : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Route Detail")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    showInfoSheet = true
                }) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            ScrollView {
                VStack(alignment: .leading) {
                    BusTypeCard(busList: Bus.all)
                    
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
                                    BusScheduleGrid(busSchedules: [
                                        Schedule(index: 0, bus: Bus(code: "BD43", platNumber: "B 3492 XXX", operationalHour: "19.00 - 17.00"), scheduleDetail: [ScheduleDetail(BusStop: BusStop(name: "dfs", coordinates: .theBreeze, schedule: [], images: [], routes: []), time: [])]),
                                        Schedule(index: 0, bus: Bus(code: "BD43", platNumber: "B 3492 XXX", operationalHour: "19.00 - 17.00"), scheduleDetail: [ScheduleDetail(BusStop: BusStop(name: "dfs", coordinates: .theBreeze, schedule: [], images: [], routes: []), time: [])])])
                                    .padding(.top)
                                },
                                isShowPreviewSchedule: false
                            )
                            
                        }
                    }
                }
            }
            .padding(.bottom, 100)
            .menuIndicator(.hidden)
            .scrollIndicators(.hidden)
            .sheet(isPresented: $showInfoSheet) {
                Text("For info")
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
//    @Previewable @State var show : Bool = false
    RouteDetail(route: Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: []))
}
