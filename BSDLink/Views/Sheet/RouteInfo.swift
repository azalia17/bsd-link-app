//
//  RouteInfo.swift
//  BSDLink
//
//  Created by Farida Noorseptiyanti on 06/04/25.
//

import SwiftUI

struct RouteInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Header
            HStack {
                Text("Additional Information")
                    .font(.title2)
                    .bold()
                Spacer()
                Text("Done")
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 8)
            
            // Bus Stops Section
            VStack(alignment: .leading, spacing: 8) {
                Text("Bus Stops")
                    .font(.headline)
                
                HStack(alignment: .top) {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.orange)
                    
                    Text("Click bus stop image to see the full picture and some additional picture (if any).")
                        .font(.body)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            // Schedule Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Schedule")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("1. Bus stop’s schedule will only show an hour schedule. If u wanna see a schedule in a specific time, try setting it from the clock button (🕒) on the right top.")
                    
                    Text("2. You have to keep in mind that the schedule isn’t always be punctual due to several reasons. There might be ±5 minutes late or early arrival from the scheduled time.")
                    
                    Text("3. The yellow colored schedule applied on Saturday, Sunday, and national holidays. On weekdays, it applied for pick-up and drop-off dedicated for Sinar Mas Employees.")
                }
                .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            // Bus Section
            VStack(alignment: .leading, spacing: 12) {
                Text("Bus")
                    .font(.headline)
                
                HStack {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.orange)
                    Text("Conventional Bus")
                }
                
                HStack {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundColor(.yellow)
                    Text("Electric Bus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
               
            Spacer()
            
            // Footer Info
            HStack {
                Spacer()
                Text("Info Sheet — Discover Screen")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    RouteInfo()
}
