//
//  RouteCountView.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 01/04/25.
//
import SwiftUI

struct RouteCount: View {
    let count: Int
    
    var body: some View {
        HStack {
            Text("\(count) Routes")
            Spacer()
        }
        .frame(maxWidth: 355, alignment: .init(horizontal: .leading, vertical: .center))
    }
}
