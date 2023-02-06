//
//  WebService.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation
import SwiftUI

class WebService: ObservableObject {
    @Published var planets = [PlanetInfos]()
    
    func loadData(completion: @escaping ([PlanetInfos]) -> ()) {
        
        // Faz a ligação com a API
        guard let url = URL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list") else {
            print("invalid url..")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("0461e37123mshf67ea53581a5e3ep1a9710jsn8921c666ebfd", forHTTPHeaderField: "X-RapidAPI-Key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let planets = try! JSONDecoder().decode([PlanetInfos].self, from: data!)
            print(planets)
            DispatchQueue.main.async {
                completion(planets)
            }
        }.resume()
    }
}
