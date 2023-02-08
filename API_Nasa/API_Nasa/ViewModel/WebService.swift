//
//  WebService.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation
import SwiftUI

enum DownloadError: Error {
  case statusNotOk
  case decoderError
}

class WebService: ObservableObject {
    
    @Published var planetsService: [PlanetInfos]
    
    init() {
        self.planetsService = []
    }
    
    @MainActor func loadData() async throws {
        
        guard let url = URL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("0461e37123mshf67ea53581a5e3ep1a9710jsn8921c666ebfd", forHTTPHeaderField: "X-RapidAPI-Key")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.timeoutInterval = 10
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
            throw DownloadError.statusNotOk
        }
        
        let decodedResponse = try JSONDecoder().decode([PlanetInfos].self, from: data)
        self.planetsService = decodedResponse.sorted(by: {$0.id < $1.id})
        print(planetsService)
    }
    
//    func loadData(completion: @escaping ([PlanetInfos]) -> ()) async -> [PlanetInfos]? {
//        // Faz a ligação com a API
//        do {
//            var request = URLRequest(url: url)
//            request.setValue("0461e37123mshf67ea53581a5e3ep1a9710jsn8921c666ebfd", forHTTPHeaderField: "X-RapidAPI-Key")
//            let (data, response) = try await URLSession.shared.data(for: request)
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                throw DownloadError.statusNotOk
//            }
//            guard let decodedResponse = try? JSONDecoder().decode([PlanetInfos].self, from: data) else {
//                throw DownloadError.decoderError
//            }
//            let orderPlanet = decodedResponse.sorted { itemA, itemB in
//                itemA.id < itemB.id
//            }
//            planetsService = orderPlanet.self
//            print(planetsService)
//            return planetsService
//        } catch {
//            print(error.localizedDescription)
//        }
//        return nil
        
        
//        var request = URLRequest(url: url)
//        request.setValue("0461e37123mshf67ea53581a5e3ep1a9710jsn8921c666ebfd", forHTTPHeaderField: "X-RapidAPI-Key")
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            let decode = try! JSONDecoder().decode([PlanetInfos].self, from: data!)
//            print(decode)
//            let orderPlanet = decode.sorted { itemA, itemB in
//                itemA.id < itemB.id
//            }
//
//            DispatchQueue.main.async {
//                completion(orderPlanet)
//            }
//        }.resume()
//    }
}
