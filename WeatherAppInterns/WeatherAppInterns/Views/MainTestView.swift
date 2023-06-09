//
//  MainTestView.swift
//  WeatherAppInterns
//
//  Created by Ulises Burns on 07/06/23.
//

import SwiftUI

struct MainTestView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor

    var body: some View {
        NavigationView {
     
            if networkMonitor.isConnected {     // If monitor detects valid network connection
            
                MainView() // show Main view
            } else {

                noNetworkView()  // No wifi view
            }
        }
     }
}

struct MainTestView_Previews: PreviewProvider {
    static var previews: some View {
      MainTestView()
       // .environmentObject(NetworkMonitor.init(isConnected: false))  // atte jimbo
    }
}
