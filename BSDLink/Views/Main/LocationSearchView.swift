//
//  LocationSearchView.swift
//  BSDLink
//
//  Created by Azalia Amanda on 07/04/25.
//

import SwiftUI

struct LocationSearchView: View {
    @Binding var startingPoint : String
    @Binding var destinationPoint : String
    @Binding var isTimePicked : Bool
    @Binding var showSearchLocationView : Bool
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                Button(action: {
                    withAnimation(.spring){
                        showSearchLocationView.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Back")
                    }
                    .padding(.bottom, 8)
                }
                SearchCard(
                    searchHandler: {
                        
                    },
                    filterHandler: {
                        
                    },
                    swapHandler: {
                        
                    },
                    startingPoint: $startingPoint,
                    destinationPoint: $destinationPoint,
                    isTimePicked: $isTimePicked
                )
                
            }
            .frame(height: 140)
            .padding()
            .background(.gray.opacity(0.2))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<20, id: \.self) { index in
                        LocationSearchResultCell()
                    }
                }
                .padding(.bottom, 70)
            }
        }
        .background(.white)
    }
}

#Preview {
    @Previewable @State var startingPoint : String = ""
    @Previewable @State var destinationPoint : String = ""
    @Previewable @State var isTimePicked : Bool = false
    @Previewable @State var show : Bool = false
    
    LocationSearchView(
        startingPoint: $startingPoint, destinationPoint: $destinationPoint, isTimePicked: $isTimePicked,showSearchLocationView: $show
    )
}
