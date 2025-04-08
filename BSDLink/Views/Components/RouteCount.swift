//
//  RouteCountView.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 01/04/25.
//
/** Complete **/
import SwiftUI

struct RouteCount: View {
    let count: Int
    
    var body: some View {
        HStack {
            Text("\(count) Routes")
                .font(.headline)
                .bold()
                .foregroundColor(.black.opacity(0.8))
            Spacer()
        }
        
    }
}
