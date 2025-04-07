//
//  ItemExpandable.swift
//  BSDLink
//
//  Created by Azalia Amanda on 02/04/25.
//
//

/** Complete **/

import SwiftUI

struct ItemExpandable<ExpandedContent: View>: View {
    let busStop: BusStop
    let fromHour: Int
    let fromMinute: Int
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
                    .fill(index != 0 ? Color.blue : .gray.opacity(0.1))
                    .frame(width: 3, height: 32) // Connect to previous item
                    .overlay(content: {
                        Rectangle()
                            .fill(index != 0 ? Color.blue : .gray.opacity(0.1))
                            .frame(width: 3, height: 32)
                            .offset(y: 20)
                    })
                
                
                Rectangle()
                    .fill(isLastItem ? .gray.opacity(0.1) : Color.blue)
                    .frame(width: 3, height: 40)
                    .offset(y: 24)
                    .overlay(
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .overlay(content: {
                                Image(systemName:"circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 12, height: 12)
                                    
                                    .foregroundColor(.gray.opacity(0.1))
                            })
                    )
                
                Rectangle()
                    .fill(isLastItem ? .gray.opacity(0.1) : Color.blue)
                    .frame(width: 3, height: isExpanded ? expandedHeight : 32)
            }
            
            ExpandableContentType(
                busStop: busStop,
                index: index,
                fromHour: fromHour,
                fromMinute: fromMinute,
                contentExpanded: contentExpanded,
                isExpanded: $isExpanded,
                expandedHeight: $expandedHeight,
                isShowPreviewSchedule: isShowPreviewSchedule
            )
        }
        .padding(.leading, 12)
        .frame(alignment: .leading)
        .background(Color.gray.opacity(0.1))
        .padding(.bottom, 1)
        .background(.white)
        .cornerRadius(10)
        //        .modifier(TextFieldGrayBackgroundColor())
    }
}

struct ExpandableContentType<ExpandedContent: View>: View {
    var busStop: BusStop
    let index: Int
    let fromHour: Int
    let fromMinute: Int
    let contentExpanded: () -> ExpandedContent
    
    @Binding var isExpanded: Bool
    @Binding var expandedHeight: CGFloat
    
    var isShowPreviewSchedule: Bool = true
    
    var body: some View {
    VStack{
            HStack {
                ImageStack(images: busStop.images)
                    .offset(y: 18)
                VStack(alignment: .leading) {
                    HStack {
                        Text(busStop.name)
                            .font(.subheadline)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading) // Align text to the left
                            .offset(y: 18)
                        Spacer()
                        Image(systemName: "chevron.up")
                            .rotationEffect(.degrees(isExpanded ? 0 : 180))
                            .foregroundColor(.blue)
                            .offset(x: -8,y: 18)
                        
                    }

                    if isShowPreviewSchedule && !isExpanded{
                        ScheduleGrid(
                            schedules: Schedule.getScheduleBusStopBased(busStopId: busStop.id, idx: index, fromHour: fromHour, fromMinute: fromMinute),
                            isMore: true,
                            spacing: 1
                        )
                        .padding(.top)
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
            .padding(.leading, 8)
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
    ItemExpandable(busStop: BusStop.getSingleStop(by: "intermoda"), fromHour: 6, fromMinute: 0, index: 1, isLastItem: true) {
        Text("Expanded Content\nMore lines\nAnother line")
                        .padding(.top)
    }
}


#Preview {
    ItemExpandable(busStop: BusStop.getSingleStop(by: "intermoda"), fromHour: 6, fromMinute: 0, index: 1, isLastItem: true) {
        Text("Expanded Content\nMore lines\nAnother line")
                        .padding(.top)
    }
}
