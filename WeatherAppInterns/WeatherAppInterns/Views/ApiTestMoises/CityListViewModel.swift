//  Created by Moises Lopez on 22/05/23.
//

import Foundation
import CoreLocation
class CityListViewModel: ObservableObject {
  
  @Published var cities: [CityViewModel] = []
  var location: String = ""
  
  
  func getWeatherForecast(){

    let apiService = ApiService.shared

    CLGeocoder().geocodeAddressString(location) { placemarks, error in
      if let error = error {
        print(error.localizedDescription)
      }
      print("Hola")
      if let lat = placemarks?.first?.location?.coordinate.latitude,
         let lon = placemarks?.first?.location?.coordinate.longitude {
        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=23892ea6d93b8685d75fae33906a91ed&units=metric") { (result: Result<Forecast,ApiService.APIError>) in
          switch result {
          case .success(let city):
            DispatchQueue.main.async {
              self.cities = city.list.map{ CityViewModel(city: $0)}
            }
            case .failure(let apiError):
            switch apiError {
            case .error(let errorString):
              print("hello")
              print(errorString)
            }
          }
        }
        print("Lat: \(lat), Lon: \(lon)")
      }
    }



  }
  
}
