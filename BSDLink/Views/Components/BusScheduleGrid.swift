//
//  BusScheduleGrid.swift
//  BSDLink
//
//  Created by Azalia Amanda on 03/04/25.
//

import SwiftUI

struct BusScheduleGrid: View {
    var busSchedules: [Schedule]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(busSchedules) { busSchedule in
                HStack() {
                    Text("Schedule \(busSchedule.index + 1):")
                        .bold()
                    Text(busSchedule.bus.platNumber)
                        .font(.subheadline)
                }
                ScheduleGrid(schedules: ScheduleTime.all, spacing: 1)
                Divider()
                    .padding(.vertical)
            }
        }
        .padding(.top)
    }
}

#Preview {
    BusScheduleGrid(busSchedules: [Schedule(index: 0, bus: Bus(code: "BD43", platNumber: "B 3492 XXX", operationalHour: "19.00 - 17.00"), scheduleDetail: [ScheduleDetail(BusStop: BusStop(name: "dfs", coordinates: .theBreeze, schedule: [], images: [], routes: []), time: [])])])
}
