//
//  ExtraInfoView.swift
//  WeatherAppInterns
//
//  Created by Gerardo Leal on 22/05/23.
//

import SwiftUI

struct Title: View {
    var body: some View{
        Text("Precipitation")
            .foregroundColor(.white)
    }
}

struct ExtraInfoView: View {
    @Binding var isPrecipitationShowing : Bool
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("ExtraInfoBackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        Text("Info1").foregroundColor(.white)
                        Text("Info1").foregroundColor(.white)
                        Text("Info1").foregroundColor(.white)
                        Text("Info1").foregroundColor(.white)
                    }
                }
            }
            //            .toolbar {
            //                ToolbarItemGroup {
            //                    Button {
            //                        isPrecipitationShowing = false
            //                    } label: {
            //                        Image(systemName: "xmark")
            //                            .padding()
            //                            .background(
            //                                Circle()
            //                                    .fill(Color(.white))
            //                            )
            //                    }
            //                }
            //            }
            //            .navigationBarTitleDisplayMode(.inline)
//            .safeAreaInset(edge: .top) {
//                HStack {
//                    Spacer()
//                    Label("Precipitation", systemImage: "drop.fill")
//                        .foregroundColor(.white)
//                    Spacer()
//                    Button {
//                        isPrecipitationShowing = false
//                    } label: {
//                        Image(systemName: "xmark")
//                            .frame(maxWidth: 1, maxHeight: 1)
//                            .padding()
//                            .background(
//                                Circle()
//                                    .fill(Color(.white))
//                            )
//                    }
//                }
//                .padding()
//                .frame(maxWidth: .infinity)
//                .background(.ultraThinMaterial)
//            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Precipitation")
                            .font(.headline)
                        Image(systemName: "drop.fill")
                    }
                    .foregroundColor(.white)
                    Label("precipitation", systemImage: "drop.fill")
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button{
                        isPrecipitationShowing = false
                    } label: {
                        XMarkButton()
                    }
                }
            }
        }
    }
}

struct ExtraInfoView_Previews: PreviewProvider {
    static private var isPrecipitationShowing = Binding.constant(false)
    
    static var previews: some View {
        ExtraInfoView(isPrecipitationShowing: isPrecipitationShowing)
    }
}
