//
//  RouteTile.swift
//  BSDLink
//
//  Created by Brayen Fredgin Cahyadi on 30/03/25.
//

/** Complete but more styling **/

import SwiftUI

struct RouteTile: View {
    
    var routeName: String
    var stops: Int

    
    var body: some View {
        HStack(){
            VStack(alignment: .leading, spacing: 5){
                Text(routeName)
                Text(String(stops) + " Stops")
            }
            Spacer()
        }
    }
}
