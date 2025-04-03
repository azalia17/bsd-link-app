//
//  HalteList.swift
//  BSDLink
//
//  Created by Farida Noorseptiyanti on 02/04/25.
//


import SwiftUI

struct HalteList: View {
    let halteNames = ["Halte A", "Halte B", "Halte C", "Halte D"] // Daftar halte

    var body: some View {
        List(halteNames, id: \.self) { halte in
            HStack {
                Image(systemName: "mappin") // Ikon lokasi
                Text(halte) // Nama halte
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    HalteList()
}
