//
//  SearchInfo.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 04/04/25.
//
import SwiftUI

struct SearchInfo: View {
    @Binding var showSearchInfo: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Search Info")
                    .font(.headline)
                
                Spacer()
                Button(action: {
                    showSearchInfo = false
                }) {
                    Text("Done")
                }
                
            }
            .padding(.horizontal)
            
            Text("Try searching the name of a bus stop to know which routes pass by it.")
                .presentationDetents([.height(150)])
                .padding()
        }
    }
}
