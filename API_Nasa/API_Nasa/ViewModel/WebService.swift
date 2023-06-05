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
   

    func load (filename: String) async throws {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
           else {
               fatalError("Couldn't find \(filename) in main bundle.")
           }

           do {
               data = try Data(contentsOf: file)
           } catch {
               fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
           }

           do {
               let decoder = try JSONDecoder().decode([PlanetInfos].self, from: data)
               DispatchQueue.main.async { [self] in
                   planetsService = decoder
                   order(planet: decoder, key: "id")
               }
           } catch {
               fatalError("Couldn't parse \(filename) as ):\n\(error)")
           }
    }
    
    
//    @MainActor func loadData() async throws {
//        guard let url = URL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list") else {
//            throw URLError(.badURL)
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("2e68fe9a08msha4b151812270feep1fae83jsn67e1e76b4267", forHTTPHeaderField: "X-RapidAPI-Key")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.timeoutInterval = 10
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode == 200 else {
//            throw DownloadError.statusNotOk
//        }
//
//        let decodedResponse = try JSONDecoder().decode([PlanetInfos].self, from: data)
//        self.planetsService = decodedResponse
//        order(planet: decodedResponse, chave: "id")
//    }
    
    func order(planet: [PlanetInfos], key: String ) {
        DispatchQueue.main.async { [self] in
            for _ in planetsService {
                switch key {
                    case "name":
                        self.planetsService = planet.sorted(by: {$0.name < $1.name})
                    case "id":
                        self.planetsService = planet.sorted(by: {$0.id < $1.id})
                    default:
                        break
                }
            }
        }
        
    }
    
//    @MainActor func loadPlusData(planetName: String) async throws {
//          guard let url = URL(string: "https://api.api-ninjas.com/v1/planets?name="+planetName) else {
//              throw URLError(.badURL)
//          }
//          
//          var request = URLRequest(url: url)
//          request.httpMethod = "GET"
//          request.setValue("YOUR API KEY", forHTTPHeaderField: "X-Api-Key")
//          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//          request.setValue("application/json", forHTTPHeaderField: "Accept")
//          request.timeoutInterval = 10
//          
//          let (data, response) = try await URLSession.shared.data(for: request)
//          
//          guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//              throw DownloadError.statusNotOk
//          }
//          
//          let decodedResponse = try JSONDecoder().decode([PlusPlanetInfos].self, from: data)
//          self.planetPlusService = decodedResponse
//      }
}
