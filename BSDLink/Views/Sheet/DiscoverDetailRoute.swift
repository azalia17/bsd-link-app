//
//  DiscoverDetailRoute.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import SwiftUI

struct DiscoverDetailRoute: View {
    var body: some View {
        
        VStack {
            Capsule()
                .foregroundColor(.gray.opacity(0.4))
                .frame(width: 48, height: 6)
                .padding(.vertical, 12)
            HStack {
                Text("Nama Rute")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    //                    showSearchInfo = true
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
                    .frame(width: .infinity, height: 50)
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
                                },
                                isShowPreviewSchedule: true
                            )
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    DiscoverDetailRoute()
}
