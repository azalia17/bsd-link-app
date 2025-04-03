//
//  ImageCarousel.swift
//  BSDLink
//
//  Created by Azalia Amanda on 03/04/25.
//

import SwiftUI

struct ImageCarousel: View {
//    let images: [String] // Image names
//    @State private var selectedImageIndex: Int = 0
//    @State private var isFullScreen: Bool = false
//    
//    var body: some View {
//        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10) {
//                    ForEach(images.indices, id: \.self) { index in
//                        Image(images[index])
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .onTapGesture {
//                                selectedImageIndex = index
//                                isFullScreen = true
//                            }
//                    }
//                }
//                .padding()
//            }
//        }
//        .fullScreenCover(isPresented: $isFullScreen) {
//            FullScreenImageView(images: images, selectedIndex: selectedImageIndex) {
//                isFullScreen = false
//            }
//        }
//    }
//}
//
//struct FullScreenImageView: View {
    let images: [String]
        @State private var index: Int = 0 // Always starts from first image
        @State private var scale: CGFloat = 1.0
        @State private var lastScale: CGFloat = 1.0
        var onClose: () -> Void
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                Color.black.opacity(0.8)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        onClose() // Tap outside to close
                    }

                TabView(selection: $index) {
                    ForEach(images.indices, id: \.self) { i in
                        Image(images[i])
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(scale)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        scale = max(1.0, lastScale * value)
                                    }
                                    .onEnded { _ in
                                        lastScale = scale
                                    }
                            )
                            .tag(i)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            Button("Close") {
                onClose()
            }.padding(.trailing)
        }
    }
}


//#Preview {
//    ImageCarousel(
//        images: ["Intermoda_1", "Intermoda_2"]
//    )
//}
