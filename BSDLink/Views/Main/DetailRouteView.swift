//
//  DetailRouteView.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 04/04/25.
//

import SwiftUI

struct DetailRouteView: View {
    let route: Route
    
    var body: some View {
        NavigationStack {
            Text(route.name)
            
        }
        
    }
}

#Preview {
    DetailRouteView(route: Route.init(name: "Test", routeNumber: "", busStops: [], bus: []))
}
