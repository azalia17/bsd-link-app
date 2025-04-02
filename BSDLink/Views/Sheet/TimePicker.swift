//
//  TimePicker.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import SwiftUI

struct TimePicker: View {
    @Binding var showTimePicker: Bool
    @Binding var timePicked: Date
    @Binding var isTimePicked: Bool

    var body: some View {
        NavigationView {
            VStack{
                DatePicker("Time", selection: $timePicked, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                Button("Reset") {
                    showTimePicker = false
                    isTimePicked = false
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showTimePicker = false
                    } label: {
                        Label("Cancel", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showTimePicker = false
                        isTimePicked = true
                    } label: {
                        Label("Done", systemImage: "checkmark")
                            .labelStyle(.iconOnly)
                    }
    //                .disabled(timePicked.isEmpty)
                }
            }
            .navigationTitle("Set Time Arrival")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
    
    
}

//#Preview {
//    TimePicker()
//}
