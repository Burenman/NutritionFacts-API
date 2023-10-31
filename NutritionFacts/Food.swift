//
//  Item.swift
//  NutritionFacts
//
//  Created by Viktor on 2023-10-30.
//

import Foundation

struct Food: Codable, Identifiable {
    let id = UUID()
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
}

class Api : ObservableObject{
    @Published var foods = [Food]()
    
    func loadData(query: String, completion:@escaping ([Food]) -> ()) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue("IxEpyP206tlcQ/T4DrStlg==MSEnCMFkMdqQY3A8", forHTTPHeaderField: "X-Api-Key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let foods = try! JSONDecoder().decode([Food].self, from: data!)
            print(foods)
            DispatchQueue.main.async {
                completion(foods)
            }
        }.resume()
    }
}
//class Api : ObservableObject{
//    @Published var foods = [Food]()
//
//    func loadData(completion:@escaping ([Food]) -> ()) {
//        let query = "1lb brisket and fries".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+query!)!
//        var request = URLRequest(url: url)
//        request.setValue("IxEpyP206tlcQ/T4DrStlg==MSEnCMFkMdqQY3A8", forHTTPHeaderField: "X-Api-Key")
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            let foods = try! JSONDecoder().decode([Food].self, from: data!)
//            print(foods)
//            DispatchQueue.main.async {
//                completion(foods)
//            }
//        }.resume()
//    }
//}
