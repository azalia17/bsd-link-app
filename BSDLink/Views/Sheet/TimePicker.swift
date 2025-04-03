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
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showTimePicker = false
                        isTimePicked = true
                    } label: {
                        Text("Done")
                            .foregroundColor(.blue)
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
