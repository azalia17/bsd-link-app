//
//  BusScheduleGrid.swift
//  BSDLink
//
//  Created by Azalia Amanda on 03/04/25.
//

/** Complete **/

import SwiftUI

struct BusScheduleGrid: View {
    var busSchedules: [Schedule]

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(busSchedules) { schedule in
                HStack {
                    Text("Schedule \(schedule.idx):")
                        .bold()
                    Text(Bus.getBus(by: schedule.bus).platNumber)
                        .font(.subheadline)
                }
                
                ScheduleGrid(schedules: [], spacing: 1)
                Divider()
                    .padding(.vertical)
            }
        }
        .padding(.top)
    }
}

#Preview {
    BusScheduleGrid(busSchedules: Schedule.all)
}
