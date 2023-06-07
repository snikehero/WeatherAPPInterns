import SwiftUI
class CityListViewModel: ObservableObject {
  @Published var cities: [CityForecastModel] = .init()// [CityViewModelRefactor]


  
  //Anadir funcion de crear el arreglo 1.-
  
  func addCity(cityToAdd: CityForecastModel) {
    cities.append(cityToAdd)
  }
  func removeCity()
  {
    cities.removeLast()
  }
  func updateData(changed: Int) {
    for i in 0..<cities.count {
      cities[i].system = changed
    }
  }

}

