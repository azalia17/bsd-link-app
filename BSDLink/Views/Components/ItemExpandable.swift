//
//  ItemExpandable.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//
//
//import SwiftUI
//
//struct ItemExpandable<Content: View, ExpandedContent: View>: View {
//    
//    let index: Int
//    let content: () -> Content
//    let contentExpanded: () -> ExpandedContent
//    
//    @State private var isExpanded: Bool = false
//    
//    var body: some View {
//
//            HStack() {
////                Spacer().frame(width: 30)
//                VStack {
//                    if index != 0 {
////                        Spacer().frame(width: 30)
//                        Path { path in
//                            path.move(to: CGPoint(x: 0, y: 0))
//                            path.addLine(to: CGPoint(x: 0, y: 4))
//                        }
//                        .stroke(Color.gray, lineWidth: 1)
//                        .padding(.leading)
//                    }
//                    Circle()
//                        .fill(Color.blue) // Replace with theme color
//                        .frame(width: 24, height: 24)
//                        .overlay(
//                            Image(systemName:"circle.fill")
//                                .resizable()
////                                .scaledToFit()
//                                .frame(width: 16, height: 16)
//                                .rotationEffect(.degrees(isExpanded ? 180 : 0))
//                                .foregroundColor(.white)
//                        )
//                    Path { path in
//                        path.move(to: CGPoint(x: 0, y: 0))
//                        path.addLine(to: CGPoint(x: 0, y: 20))
//                    }
//                    .stroke(Color.gray, lineWidth: 1)
//                    .padding(.leading)
//                }
//                .background(.red)
//                
////                Spacer().frame(width: 8)
//                VStack(alignment: .leading) {
//                    content()
//                    if isExpanded {
////                        Spacer().frame(height: 8)
//                        contentExpanded()
//                    }
//                }
////                Spacer().frame(width: 30)
//                Spacer()
//                    .background(.yellow)
//            }
//            .background(.green)
//            .contentShape(Rectangle())
//            .onTapGesture {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }
//        
//    }
//}
//
//struct ItemExpandedLoading: View {
//    let count: Int = 3
//    
//    var body: some View {
//        List(0..<count, id: \.self) { index in
//            ItemExpandable(index: index, content: {
//                ShimmerEffect(width: 90, height: 14)
//            }, contentExpanded: {
//                ShimmerEffect(width: 100, height: 12)
//            })
//        }
//    }
//}
//
//struct ShimmerEffect: View {
//    let width: CGFloat
//    let height: CGFloat
//    
//    var body: some View {
//        RoundedRectangle(cornerRadius: 6)
//            .fill(Color.gray.opacity(0.3))
//            .frame(width: width, height: height)
//            .redacted(reason: .placeholder)
//    }
//}
//
//struct VerticalLine: View {
//    var body: some View {
//        Path { path in
//            path.move(to: CGPoint(x: 100, y: 50)) // Starting point (x: 100, y: 50)
//            path.addLine(to: CGPoint(x: 100, y: 300)) // End point (x: 100, y: 300)
//        }
//        .stroke(Color.blue, lineWidth: 5) // Line color & thickness
//    }
//}
//
//#Preview {
//    ItemExpandable(index: 3, content: {
//        Text("Main Content")
//            .frame(maxWidth: .infinity)
//    }, contentExpanded: {
//        Text("Expanded Content")
//    })
//    //    .previewLayout(.sizeThatFits)
//}


import SwiftUI

//struct ItemExpandable<Content: View, ExpandedContent: View>: View {
//    
//    let index: Int
//    let content: () -> Content
//    let contentExpanded: () -> ExpandedContent
//    
//    @State private var isExpanded: Bool = false
//    @State private var expandedHeight: CGFloat = 0  // Store the expanded height
//    
//    var body: some View {
//        VStack {
//            HStack(alignment: .top) {
//                VStack {
//                    if index != 0 {
//                        Rectangle()
//                            .fill(Color.gray)
//                            .frame(width: 3, height: 114) // Small divider above
//                            .offset(y: 8)
//                    }
//                    
//                    Circle()
//                        .fill(Color.blue)
//                        .frame(width: 24, height: 24)
//                    
//                    if isExpanded {
//                        Rectangle()
//                            .fill(Color.gray)
//                            .frame(width: 1, height: expandedHeight) // Dynamic line
//                    } else {
//                        Rectangle()
//                            .fill(Color.gray)
//                            .frame(width: 1, height: 20) // Default small height
//                    }
//                }
//                
//                Spacer().frame(width: 8)
//                
//                VStack(alignment: .leading) {
//                    content()
//                    
//                    if isExpanded {
//                        Spacer().frame(height: 8)
//                        
//                        // Measure expanded content height
//                        GeometryReader { geometry in
//                            VStack {
//                                contentExpanded()
//                                    .background(GeometryReader { innerGeo in
//                                        Color.clear
//                                            .onAppear {
//                                                expandedHeight = innerGeo.size.height
//                                            }
//                                    })
//                            }
//                        }
//                        .frame(height: expandedHeight)
//                    }
//                }
//                Spacer().frame(width: 30)
//            }
//            .contentShape(Rectangle())
//            .onTapGesture {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }
//        }
//    }
//}
//
struct ItemExpandable<Content: View, ExpandedContent: View>: View {
    
    let index: Int
    let isLastItem: Bool  // Pass info if this is the last item
    let content: () -> Content
    let contentExpanded: () -> ExpandedContent
    
    @State private var isExpanded: Bool = false
    @State private var expandedHeight: CGFloat = 0  // Store the expanded height
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack {
                // Top line (connects to the previous item)
                if index != 0 {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 3, height: 32) // Connect to previous item
                        .offset(y: 10)
                }
                
                Circle()
                    .fill(Color.orange)
                    .frame(width: 24, height: 24)
                    .overlay(
                        Image(systemName:"circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .foregroundColor(.white)
                    )
                    
                
                // Bottom line (only show if expanded or not last item)
                if isExpanded || !isLastItem {
                    Rectangle()
                        .fill(Color.orange)
//                        .frame(width: 1, height: .infinity)
                        .frame(width: 3, height: isExpanded ? expandedHeight : 32)
                        .offset(y: -10)
                }
            }
            
            HStack(/*alignment: .leading*/) {
                ImageStack(firstImage: "Intermoda_1")
                    .offset(y: 18)
                
                VStack{
                    content()
                        .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                        .offset(y: 18)
                        
                    
                    if isExpanded {
    //                    Spacer().frame(height: 8)
                        
                        // Measure expanded content height
                        GeometryReader { geometry in
                            VStack {
                                contentExpanded()
                                    .background(GeometryReader { innerGeo in
                                        Color.clear
                                            .onAppear {
                                                expandedHeight = innerGeo.size.height
                                            }
                                    })
                            }
                        }
                        .frame(height: expandedHeight)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
//                    withAnimation {
                        isExpanded.toggle()
//                    }
                }
            }
            
//            .padding(.leading, 8) // Ensures alignment with the circle
        }
        
        
    }
}
//
//struct ItemExpandables<Content: View, ExpandedContent: View>: View {
//    let index: Int
//    let hasNextItem: Bool
//    let content: () -> Content
//    let contentExpanded: () -> ExpandedContent
//    
//    @State private var isExpanded: Bool = false
//    
//    var body: some View {
//        HStack(alignment: .top, spacing: 8) {
//            VStack {
//                // Connect to the previous item
//                if index != 0 {
//                    Rectangle()
//                        .fill(Color.gray)
//                        .frame(width: 1, height: 8)
//                }
//                
//                Circle()
//                    .fill(Color.blue)
//                    .frame(width: 24, height: 24)
//                
//                // Connect to the next item or expand when needed
//                if isExpanded || hasNextItem {
//                    Rectangle()
//                        .fill(Color.gray)
//                        .frame(width: 3, height: .infinity)
////                        .frame(width: 1, maxHeight: .infinity) // Fill the remaining space
//                }
//            }
//            
//            VStack(alignment: .leading) {
//                content()
//                    .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
//                
//                if isExpanded {
//                    Spacer().frame(height: 8)
//                    contentExpanded()
//                }
//            }
//            .contentShape(Rectangle()) // Expandable area
//            .onTapGesture {
//                withAnimation {
//                    isExpanded.toggle()
//                }
//            }
//        }
//        .padding(.vertical, 4)
//    }
//}

//struct ItemExpandedLoading: View {
//    let count: Int = 3
//    
//    var body: some View {
//        List(0..<count, id: \.self) { index in
//            ItemExpandable(index: index, content: {
//                ShimmerEffect(width: 90, height: 14)
//            }, contentExpanded: {
//                ShimmerEffect(width: 100, height: 12)
//            })
//        }
//    }
//}
//
//struct ShimmerEffect: View {
//    let width: CGFloat
//    let height: CGFloat
//    
//    var body: some View {
//        RoundedRectangle(cornerRadius: 6)
//            .fill(Color.gray.opacity(0.3))
//            .frame(width: width, height: height)
//            .redacted(reason: .placeholder)
//    }
//}

#Preview {
    ItemExpandable(
        index: 1,
        isLastItem: false,
        content: {
            Text("Main Content")
//            .frame(maxWidth: .infinity)
    }, contentExpanded: {
        Text("Expanded Content\nMore lines\nAnother line")
            .padding(.top)
    })
}
