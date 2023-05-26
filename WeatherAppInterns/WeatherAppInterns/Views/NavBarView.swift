//
//  NavBarView.swift
//  WeatherApp
//
//  Created by Leo Avalos on 16/05/23.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
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
