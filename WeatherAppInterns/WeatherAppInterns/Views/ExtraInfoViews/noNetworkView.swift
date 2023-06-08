//
//  noNetworkView.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 07/06/23.
//

import SwiftUI

struct noNetworkView: View {
  var body: some View {
   
      VStack{
        
        Image(systemName: "wifi.slash")
          .foregroundColor(Color(.white))
          .font(.system(size: 40))
          .padding()
        TitleText(text: "Weather not available")
        
        NormalText(text: "The weather app has no internet conection. To see the forecast check your internet conection and try again.")
          .padding(.init(top: 1, leading: 20, bottom: 100, trailing: 20))
          .multilineTextAlignment(.center)
        
      }
    
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("BackgroundColor"))
    .ignoresSafeArea()
  }
}

struct noNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        noNetworkView()
    }
}
