//
//  DataView.swift
//  WeatherAppInterns
//
//  Created by Moises Lopez on 17/05/23.
//

import SwiftUI
import CoreLocation
struct DataView: View {
  @State private var location: String = ""
  @State  var forecast: MyWeatherList? = nil
  let dataFormatter = DateFormatter()
  init() {
    dataFormatter.dateFormat = "EEEE, d, HH:mm"
  }
    var body: some View {
    NavigationView {
      VStack{
        
        
        HStack {
          TextField("Enter Location", text: $location)
            .textFieldStyle(RoundedBorderTextFieldStyle())
          Button {
            getWeatherForecast(for: location)
          } label: {
            Image(systemName: "magnifyingglass.circle.fill")
              .font(.title3)
          }
        }
        if let forecast = forecast {
          List(forecast.list, id: \.dt) { hourly in
            VStack(alignment: .leading){
              Text(dataFormatter.string(from: hourly.dt))
                .fontWeight(.bold)
              HStack(alignment: .top)
              {
                Image(systemName: "hourglass")
                  .font(.title)
                  .frame(width: 50, height: 50)
                  .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                VStack(alignment: .leading)
                {
                  Text(hourly.weather[0].description.capitalized)
                  Text("High: \(hourly.main.tempMax, specifier: "%.0f")")
                  
                  Text("Low: \(hourly.main.tempMin, specifier: "%.0f")")
                  
                  Text("Presion: \(hourly.main.pressure, specifier: "%.0f")")
                  
                  Text("Sensacion: \(hourly.main.fellsLike, specifier: "%.0f")")
                 
                  Text("Velocidad: \(hourly.wind.speed, specifier: "%.1f")")
                  
                }
              }
            }
          }
          .listStyle(PlainListStyle())
        }else {
          Spacer()
        }
      }
      .padding(.horizontal)
      .navigationTitle("Mobile Weather")
    }
  }
  func getWeatherForecast(for location: String){
    
    let apiService = ApiService.shared
    
    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
      if let lat = placemarks?.first?.location?.coordinate.latitude,
         let lon = placemarks?.first?.location?.coordinate.longitude {
        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric") { (result: Result<MyWeatherList,ApiService.APIError>) in
          switch result {
          case .success(let forecast):
            self.forecast = forecast
//            for times in forecast.list   {
//              print(dataFormatter.string(from: times.dt))
//              print("Temperatura: ",times.main.temp)
//              print("Temperatura Maxima: ",times.main.tempMax)
//              print("Temperatura Minima: ",times.main.tempMin)
//              print("Presion: ",times.main.pressure)
//              print("Sensacion: ",times.main.fellsLike)
//              print("Speed",times.wind.speed)
//              print("Visibilidad: ",times.visibility)
//              print("Precipitqacion: ", times.pop)
//              print("Description: ", times.weather[0].description)
//              print("Id: ",times.weather[0].id)
//              print("Icon URL: ", times.weather[0].weatherIconURL)
            //      }
          case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
              print(errorString)
            }
          }
        }
        
      }
    }
    
    
    

  }
}

struct DataView_Previews: PreviewProvider {
  static var previews: some View {
    DataView()
  }
}
