import SwiftUI
class CityListViewModel: ObservableObject {
  @Published var cities: [CityForecastModel] = .init()// [CityViewModelRefactor]

  
  //Anadir funcion de crear el arreglo 1.-
  
  func addCity(cityToAdd: CityForecastModel) {
    cities.append(cityToAdd)
    print(cities.count)
  }
}
