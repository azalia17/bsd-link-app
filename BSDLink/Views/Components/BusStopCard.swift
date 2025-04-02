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
                    busStopName: "Courts Mega Store \(index)",
                    index: index,
                    isLastItem: index == 2,
                    contentExpanded: {
                        ScheduleGrid(schedules: ScheduleTime.all, spacing: 4)
                            .padding([.top, .trailing])
                    },
                    isShowPreviewSchedule: true
                )
            }
        }
    }
}

#Preview {
    BusStopCard()
}
