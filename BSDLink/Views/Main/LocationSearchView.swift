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
    
    @State var activeTextField: String = ""
    
    @StateObject var viewModel = LocationSearchViewModel()
    
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
                    startingPoint: $viewModel.startLocationQueryFragment,
                    destinationPoint: $viewModel.endLocationQueryFragment,
                    activeTextField: $activeTextField,
                    isTimePicked: $isTimePicked,
                    showSearchLocationView: $showSearchLocationView
                ) {}
            }
            .frame(height: 140)
            .padding()
            .background(.gray.opacity(0.2))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(
                            title: result.title,
                            subtitle: result.subtitle
                        ).onTapGesture {
                            viewModel.selectLocation(result.title, textField: activeTextField)
                        }
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
