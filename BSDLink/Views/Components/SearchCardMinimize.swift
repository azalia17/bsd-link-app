//
//  SearchCardMinimize.swift
//  BSDLink
//
//  Created by Azalia Amanda on 09/04/25.
//

import SwiftUI

struct SearchCardMinimize: View {
    let action: () -> Void
    let from: String
    let to: String
    
    var body: some View {
        HStack(alignment: .top) {
            //                            Button()
            Button("Back", systemImage: "chevron.backward") {
//                isSearch = false
//                showLocationSearchView = true
//                locationViewModel.reset()
//                locationViewModel.routePolylines.removeAll()
//                locationViewModel.route = MKRoute()
                action()
            }
            .frame(height: 35/*, alignment: .center*/)
            .labelStyle(.iconOnly)
            .buttonStyle(.borderedProminent)
            .tint(.white)
            .foregroundColor(.black)
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            
            HStack{
                Text(from)
                    .lineLimit(1)
                Image(systemName: "arrow.forward")
                Text(to)
                    .lineLimit(1)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white)
                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: .infinity, alignment: .leading)
            )
            .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
            
    
        }
        .background()
    }
    }


//#Preview {
//    SearchCardMinimize()
//}
