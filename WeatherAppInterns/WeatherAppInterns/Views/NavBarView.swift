//
//  NavBarView.swift
//  WeatherApp
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
       VStack {
          
          HStack{
             Button {
               //Open maps view
             } label: {
                ButtonView(systemName: "map")
             }
             Spacer()
             Button {
               //Open maps view
             } label: {
                ButtonView(systemName: "list.dash")
             }

          }
          .padding( .init(top: 10, leading:20, bottom: 10, trailing: 20 ))
       .background(Color("ButtonColor"))
       }
       
    }
}


struct ButtonView: View {
   var systemName: String
   var body: some View {
      Image(systemName: systemName)
         .font(.title)
         .foregroundColor(.white)
   }
}


struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}
