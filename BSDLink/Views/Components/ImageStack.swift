//
//  ImageStack.swift
//  BSDLink
//
//  Created by Azalia Amanda on 01/04/25.
//

import SwiftUI

struct ImageStack: View {
    var firstImage: String
    var secondImage: String? = nil
    
    var body: some View {
        ZStack{
            if(secondImage != nil) {
                Image(secondImage ?? "")
                    .resizable()
                    .frame(width: 72, height: 72)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .offset(x: 8, y: 8)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .padding(12)
                    .frame(width: 72, height: 72, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .offset(x: 8, y: 8)
            }
            Image(firstImage)
                .resizable()
                .frame(width: 72, height: 72)
                .border(.white)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 7, y: 8)
        }
    }
}

#Preview {
    ImageStack(
        firstImage: "Intermoda_1",
        secondImage: "Intermoda_2"
    )
}
