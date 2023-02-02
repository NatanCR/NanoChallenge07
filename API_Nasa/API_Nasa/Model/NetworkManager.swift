//
//  NetworkManager.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 01/02/23.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    
    @Published var planets = [PlanetInfos]()
    
    func fetchData(planetName: String) {
        let name = "\(planetName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/planets?name="+name!)!
        var request = URLRequest(url: url)
        request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
  
    
    
    //    func fetchData(planetName: String) {
    //        if let url = URL(string: "xxxxx\(planetName)xxxxx") {
    //            let session = URLSession(configuration: .default)
    //            let task = session.dataTask(with: url) { (data, response, error) in
    //                if error == nil {
    //                    let decoder = JSONDecoder() //decodifica os dados recuperados da sessão de rede
    //                    if let safeData = data {
    //                        do {
    //                            let results = try decoder.decode(Results.self, from: safeData) //obtem os dados da API
    //                            DispatchQueue.main.async { //prioriza na primeira thread
    //                                self.posts = results.hits
    //                            }
    //                        } catch {
    //                            print(error)
    //                        }
    //
    //                    }
    //                }
    //            }
    //            task.resume()
    //        }
    //    }
    
    
    
//    func performRequest(with urlString: String) {
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error == nil {
//                    let decoder = JSONDecoder()
//                    if let safeData = data {
//                        do {
//                            let results = try decoder.decode(PlanetInfos, from: safeData)
//                            DispatchQueue.main.async {
//                                self.planets = results
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}
