//
//  SearchCard.swift
//  BSDLink
//
//  Created by Azalia Amanda on 31/03/25.
//

/** Add function and user input **/

import SwiftUI

struct SearchCard: View {
    
    var searchHandler: () -> Void
    var filterHandler: () -> Void
    var swapHandler: () -> Void
    var resetResultsCompletion: () -> Void
    
    @Binding var startingPoint : String
    @Binding var destinationPoint : String
    @Binding var activeTextField : String
    @Binding var isTimePicked : Bool
    @Binding var showSearchLocationView : Bool
    var action: () -> Void
    
    // Define focus states
    enum Field {
        case from
        case to
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        HStack (alignment: .center) {
            HStack(alignment: .center){
                VStack(alignment: .leading) {
                    Text("From")
                        .opacity(0.7)
                    Spacer()
                    Spacer()
                    Text("To")
                        .opacity(0.7)
                    Spacer()
                }
                if (showSearchLocationView) {
                    VStack {
                        Spacer()
                        TextField("Search Location", text: $startingPoint)
                            .focused($focusedField, equals: .from)
                            .modifier(TextFieldGrayBackgroundColor())
                            .padding(.top)
                            .onChange(of: startingPoint) { oldValue, newValue in
                                activeTextField = "from"
                            }
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .to
                                resetResultsCompletion()
                            }
                            
                        //                            .on
                        Spacer()
                        
                        TextField("Search Location", text: $destinationPoint)
                            .focused($focusedField, equals: .to)
                            .modifier(TextFieldGrayBackgroundColor())
                            .padding(.bottom)
                            .onChange(of: destinationPoint) { oldValue, newValue in
                                activeTextField = "to"
                            }
                            .submitLabel(.search)
                            .onSubmit {
                                searchHandler()
//                                print(ScheduleDetail.all)
                            }
                        //                            .k
                        Spacer()
                    }.onChange(of: focusedField) { oldValue, newValue in
                        resetResultsCompletion()
                    }
                    
                } else {
                    VStack {
                        Spacer()
                        TextField("Search Location", text: $startingPoint)
                            .modifier(TextFieldGrayBackgroundColor())
                            .padding(.top)
                            .disabled(true)
                        Spacer()
                        
                        TextField("Search Location", text: $destinationPoint)
                            .modifier(TextFieldGrayBackgroundColor())
                            .padding(.bottom)
                            .disabled(true)
                        Spacer()
                    }
                    .onTapGesture {
                        action()
                    }
                    
                }
                
                
                Spacer()
//                Divider()
//                Spacer()
                VStack {
                    Spacer()
                    Spacer()
                    
                    Button(action: {
                        swapHandler()
                    }) {
                        Image(systemName: "rectangle.2.swap")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
                    .disabled(startingPoint == "" || destinationPoint == "")

//                    Spacer()
                    
                    Button(action: {
                        filterHandler()
                    }) {
                        Image(systemName: isTimePicked ? "line.3.horizontal.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(isTimePicked ? .blue : .black)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)

                    
//                    Button("Swap", systemImage: "rectangle.2.swap") {
//                        swapHandler()
//                    }
//                    .frame(width: 44, height: 44)
////                    .frame(height: 35, alignment: .center)
//                    .labelStyle(.iconOnly)
//                    .buttonStyle(.borderedProminent)
//                    
//                    .tint(.white)
//                    .foregroundColor(.black)
//                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
//                    
//                    Spacer()
//                    
//                    Button("Filter", systemImage: isTimePicked ? "line.3.horizontal.decrease.fill" : "line.horizontal.3.decrease.circle") {
//                        filterHandler()
//                    }
//                    .frame(width: 44, height: 44)
//                    .labelStyle(.iconOnly)
//                    .buttonStyle(.borderedProminent)
//                    .tint(.white)
//                    .foregroundColor(isTimePicked ? .blue : .black)
//                    .shadow(color: Color.black.opacity(0.1), radius: 15, x: 0, y: 10)
                    
                    Spacer()
                    Spacer()
                }
//                .background(
//                    RoundedRectangle(cornerRadius: 10, style: .continuous)
//                        .fill(.white)
//                        .frame(maxWidth: .infinity)
//                        .frame(maxWidth: .infinity, alignment: .leading)
////                        .padding(.trailing, 40)
//                )
//                Button("Search", systemImage: "magnifyingglass") {
//                    searchHandler()
//                }
//                .frame(height: 35, alignment: .center)
//                .labelStyle(.iconOnly)
//                .foregroundColor(.black)
//                .disabled(startingPoint.isEmpty && destinationPoint.isEmpty)
            }
            .frame(height: 90)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.white)
                    .frame(maxWidth: .infinity)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.trailing, 40)
            )
            
            
        }
        
    }
    
}

struct TextFieldGrayBackgroundColor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(.gray.opacity(0.1))
            .cornerRadius(8)
            .foregroundColor(.primary)
    }
}

//#Preview {
//    SearchCard()
//}
