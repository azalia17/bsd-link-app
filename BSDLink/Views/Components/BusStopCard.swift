//
//  BusStopCard.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import SwiftUI

struct BusStopCard: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { index in
                ItemExpandable(
                    index: index,
                    isLastItem: index == 2,
                    content: {
                        Text("Main Content")
                            .font(.headline)
                }, contentExpanded: {
                        ScheduleGrid(schedules: ScheduleTime.all, spacing: 8)
                    .padding(.top)
                })
            }
        }
    }
}

#Preview {
    BusStopCard()
}
