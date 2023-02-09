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
        self.planetsService = decodedResponse
            .sorted(by: {$0.name < $1.name})
        
        
    }
   
}
