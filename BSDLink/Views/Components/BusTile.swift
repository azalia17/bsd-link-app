//
//  BusTile.swift
//  BSDLink
//
//  Created by Azalia Amanda on 19/03/25.
//

/** Not Used **/

import SwiftUI

struct BusTile: View {
    var body: some View {
        VStack {
            HStack (alignment: .top) {
                AsyncImage(url: URL(string: "https://www.forksoverknives.com/wp-content/uploads/fly-images/98892/Creamy-Carrot-Soup-for-Wordpress-360x270-x.jpg")) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 180, alignment: .center)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 180, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))

                }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                VStack (alignment: .leading,content: {
                    HStack {
                        Chip(text: "B04", color: Color.red)
                        Chip(text: "B 1038 XYS", color: Color.gray)
                    }
                    Text("Rute 1 | The Breeze - AEON")
                        .bold()
                })
            }
        }
        .padding(20)
        .frame(width: .infinity, height: 217, alignment: .top)
        .background(Color.white)
//        .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
//        .safeAreaPadding()
    }
}

#Preview {
    BusTile()
}
