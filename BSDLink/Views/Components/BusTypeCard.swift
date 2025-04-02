//
//  BusTypeCard.swift
//  BSDLink
//
//  Created by Farida Noorseptiyanti on 02/04/25.
//


import SwiftUI

struct BusTypeList: View {
    // Data bus yang akan ditampilkan
    let busList: [Bus] = [
        Bus(name: "Bus A", code: "A001", plat: "B1234ABC", operationalTime: "07.00 - 17.00"),
        Bus(name: "Bus B", code: "B002", plat: "B5678XYZ", operationalTime: "08.00 - 18.00"),
        Bus(name: "Bus C", code: "C003", plat: "C9876JKL", operationalTime: "06.00 - 16.00")
    ]
    
    var body: some View {
        NavigationView {
            List(busList) { bus in
                BusTypeCard(bus: bus)
            }
            .navigationTitle("BSD Link Bus")
        }
    }
}

struct BusTypeCard: View {
    @State private var isExpanded = false // State untuk mengontrol tampilan disclosure
    let bus: Bus
    
    var body: some View {
        DisclosureGroup(
            isExpanded ? "Hide Bus Details" : "Show Bus Details",
            isExpanded: $isExpanded
        ) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: "bus.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                        
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Code: \(bus.code)")
                                .bold()
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(RoundedRectangle(cornerRadius: 6).fill(Color.gray.opacity(0.2)))
                            Text("Plat: \(bus.plat)")
                                .bold()
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(RoundedRectangle(cornerRadius: 6).fill(Color.gray.opacity(0.2)))
                        }
                        Text("Jam Operasional: \(bus.operationalTime)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .padding()
    }
}

struct Bus: Identifiable {
    let id = UUID() // Unique identifier for each bus
    let name: String
    let code: String
    let plat: String
    let operationalTime: String
}

#Preview {
    BusTypeList()
}
