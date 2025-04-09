//
//  QuickSearch.swift
//  BSDLink
//
//  Created by Azalia Amanda on 31/03/25.
//

/** Complete ps. not sure. should i add the lat long **/

import SwiftUI

struct QuickSearch: View {
    @Binding var startingPoint : String
    @Binding var destinationPoint : String
    
    
    var body: some View {
        HStack {
            Text("Suggestion :")
                .font(.headline)
                .foregroundColor(.black)
                .shadow(color: .white, radius: 3)
            Text("-")
//            ScrollView(.horizontal) {
//                HStack {
//                    ForEach(1..<8) { index in
//                        Button ("Route \(index) - \(index + 1)") {
//                            startingPoint = "Route \(index)"
//                            destinationPoint = "Route \(index + 1)"
//                        }
//                        .buttonStyle(.borderedProminent)
//                        .tint(.white)
//                        .foregroundColor(.black)
////                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 7, y: 8)
//                    }
//                }
//            }
//            .scrollIndicators(.hidden)
        }
        .padding(.top, 10)
    }
}
