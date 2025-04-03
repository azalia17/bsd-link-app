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
                
                Spacer()
                
                Image(systemName: "arrowshape.forward.fill") // Panah arah
                    .padding()
                
                VStack {
                    Image(systemName: "photo") // Ikon foto
                    Text("Bus Stop Name") // Deskripsi
                        .font(.caption)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    HalteList()
}
