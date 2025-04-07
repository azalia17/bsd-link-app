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
            Capsule()
                .foregroundColor(.gray.opacity(0.4))
                .frame(width: 48, height: 6)
                .padding(.bottom, 12)
                .padding(.top, 12)
            
            HStack {
                Text(route.name)
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
//            .padding(.top, 50)
            
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
                        ForEach(0..<3) { index in
//                            ItemExpandable(
//                                busStopName: "Courts Mega Store \(index)",
//                                index: index,
//                                isLastItem: index == 2,
//                                contentExpanded: {
//                                    BusScheduleGrid(busSchedules: [])
//                                    .padding(.top)
//                                },
//                                isShowPreviewSchedule: false
//                            )
                            
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
    @Previewable @State var show : Bool = false
    RouteDetail(route: Route.all[0])
//    RouteDetail(route: Route(name: "aaa", routeNumber: "Route 1", busStops: [], bus: []))
}
