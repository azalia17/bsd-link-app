//
//  ScheduleGrid.swift
//  BSDLink
//
//  Created by Azalia Amanda on 01/04/25.
//

/** Complete **/

import SwiftUI

struct ScheduleGrid: View {
    var schedules: [ScheduleTime]
    var isMore: Bool = false
    var spacing: CGFloat = 2
    
    var body: some View {
        if (schedules.count > 1) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 62), spacing: spacing)], alignment: .leading, spacing: 8, content: {
                ForEach(schedules) { schedule in
                    ScheduleChip(text: formatTime(from: schedule.time), isRegular: schedule.isRegular)
                }
                if isMore {
                    ScheduleChip(text: "...")

                }
            })
        } else {
            HStack() {
                ScheduleChip(text: "No Schedule Available")
                Spacer()
            }
        }
    }
}

struct ScheduleChip: View {
    var text: String
    var isRegular: Bool = true
    
    var body: some View {
        if isRegular {
            Chip(text: text, color: .gray.opacity(0.1), textColor: .gray)
        } else {
            Chip(text: text, color: .yellow.opacity(0.17), textColor: .orange.opacity(0.8))
        }
    }
}

#Preview {
    ScheduleGrid(schedules: [])
}
