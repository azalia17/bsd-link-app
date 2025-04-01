//
//  BusStopCard.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//

import SwiftUI

struct BusStopCard: View {
    var body: some View {
        ForEach(1..<3) { index in
            ItemExpandable(
                index: index,
                isLastItem: false,
                content: {
                    Text("Main Content")
            }, contentExpanded: {
                Text("Expanded Content\nMore lines\nAnother line")
                    .padding(.top)
            })
        }
    }
}

#Preview {
    BusStopCard()
}
