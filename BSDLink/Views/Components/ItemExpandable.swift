//
//  ItemExpandable.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//
//

import SwiftUI

struct ItemExpandable<ExpandedContent: View>: View {
    let busStopName: String
    let index: Int
    let isLastItem: Bool  // Pass info if this is the last item
    let contentExpanded: () -> ExpandedContent
    
    @State private var isExpanded: Bool = false
    @State private var expandedHeight: CGFloat = 0  // Store the expanded height
    
    var isShowPreviewSchedule: Bool = true
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Rectangle()
                    .fill(index != 0 ? Color.orange : .white)
                    .frame(width: 3, height: 32) // Connect to previous item
                    .overlay(content: {
                        Rectangle()
                            .fill(index != 0 ? Color.orange : .white)
                            .frame(width: 3, height: 32)
                            .offset(y: 20)
                    })
                
                Rectangle()
                    .fill(isLastItem ? .white : Color.orange)
                    .frame(width: 3, height: 40)
                    .offset(y: 24)
                    .overlay(
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 24, height: 24)
                            .overlay(content: {
                                Image(systemName:"circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    
                                    .foregroundColor(.white)
                            })
                    )
                
                Rectangle()
                    .fill(isLastItem ? .white : Color.orange)
                    .frame(width: 3, height: isExpanded ? expandedHeight : 32)
            }
            
            
            
            ExpandableContentType(
                busStopName: busStopName,
                contentExpanded: contentExpanded,
                isExpanded: $isExpanded,
                expandedHeight: $expandedHeight,
                isShowPreviewSchedule: isShowPreviewSchedule
            )
            
        }
        .padding(.leading, 12)
//        .overlay(alignment: .topTrailing, content: {
//            Image(systemName: "chevron.up.circle.fill")
//                .rotationEffect(.degrees(isExpanded ? 180 : 0))
//                .foregroundColor(.orange)
//                .offset(y: 20)
//                .padding(.trailing)
//        })
    }
}

struct ExpandableContentType<ExpandedContent: View>: View {
    
    var busStopName: String
    let contentExpanded: () -> ExpandedContent
    
    @Binding var isExpanded: Bool
    @Binding var expandedHeight: CGFloat
    
    var isShowPreviewSchedule: Bool = true
    
    var body: some View {
        VStack{
            HStack {
                ImageStack(firstImage: "Intermoda_1")
                    .offset(y: 18)
                VStack {
                    HStack {
                        Text(busStopName)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                            .offset(y: 18)
                        Spacer()
                        Image(systemName: "chevron.up.circle.fill")
                            .rotationEffect(.degrees(isExpanded ? 180 : 0))
                            .foregroundColor(.orange)
                            .offset(y: 18)
                    }
                    .padding(.trailing)
                    if isShowPreviewSchedule && !isExpanded{
                        ScheduleGrid(
                            schedules: [ScheduleTime.all[0], ScheduleTime.all[1], ScheduleTime.all[2]],
                            isMore: true
                        )
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .padding(.leading, 8)
            }
            .padding(.leading)
            if isExpanded {
                GeometryReader { geometry in
                    VStack {
                        contentExpanded()
                            .background(GeometryReader { innerGeo in
                                Color.clear
                                    .onAppear {
                                        expandedHeight = innerGeo.size.height + 24
                                    }
                            })
                            .padding(.leading)
                    }
                }
                .frame(height: expandedHeight)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    ItemExpandable(
        busStopName: "aaaaaa",
        index: 1,
        isLastItem: false,
        contentExpanded: {
            Text("Expanded Content\nMore lines\nAnother line")
                .padding(.top)
        })
}
