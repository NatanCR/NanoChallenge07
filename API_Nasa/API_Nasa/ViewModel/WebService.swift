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
    @Published var planetPlusService: [PlusPlanetInfos]
    
    init() {
        self.planetsService = []
        self.planetPlusService = []
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
        self.planetsService = decodedResponse

        order(planet: decodedResponse, chave: "id")
    }
    
    
    func order(planet: [PlanetInfos], chave: String ) {
        for _ in planetsService {
            switch chave {
                case "name":
                    return self.planetsService = planet.sorted(by: {$0.name < $1.name})
                case "id":
                    return self.planetsService = planet.sorted(by: {$0.id < $1.id})
                default:
                    break
            }
        }
    }
    
    @MainActor func loadPlusData(planetName: String) async throws {
          guard let url = URL(string: "https://api.api-ninjas.com/v1/planets?name="+planetName) else {
              throw URLError(.badURL)
          }
          
          var request = URLRequest(url: url)
          request.httpMethod = "GET"
          request.setValue("ug9X/f+ARXxvDHT34AA9bg==XG2hY2UdsMtiuT5U", forHTTPHeaderField: "X-Api-Key")
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.setValue("application/json", forHTTPHeaderField: "Accept")
          request.timeoutInterval = 10
          
          let (data, response) = try await URLSession.shared.data(for: request)
          
          guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
              throw DownloadError.statusNotOk
          }
          
          let decodedResponse = try JSONDecoder().decode([PlusPlanetInfos].self, from: data)
          self.planetPlusService = decodedResponse
        print(planetPlusService)
      }
}
