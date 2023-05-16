//
//  LoadingView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 16/05/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
      ProgressView()
        .frame(height: 0.0)
        .progressViewStyle(CircularProgressViewStyle(tint: .white))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
