//
//  Chip.swift
//  BSDLink
//
//  Created by Azalia Amanda on 19/03/25.
//

import SwiftUI

struct Chip: View {
    var text: String
    var color: Color = Color.blue
    
    var body: some View {
        VStack {
            Text(text)
                .bold()
                .foregroundColor(Color.white.opacity(0.8))
        }
        .padding(12)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

#Preview {
    Chip(text: "Hello")
}
