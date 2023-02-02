//
//  NetworkManager.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 01/02/23.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    
    
    // configura o cabeçalho com a key
    let headers = [
        "X-RapidAPI-Key": "2e68fe9a08msha4b151812270feep1fae83jsn67e1e76b4267",
        "X-RapidAPI-Host": "planets-info-by-newbapi.p.rapidapi.com"
    ]
    
    // Solicita o requisição
    let request = NSMutableURLRequest(url: NSURL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)

    // Declara o tipo de requisição
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers


    // Faz a ligação com a API
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        guard let responseData = data else { return }
        
        do {
            if let responseString = String(data: responseData, encoding: .utf8) {
                print(responseString)
            }
        }
    })

    //aguarda o dado ser retornado
    dataTask.resume()
    
    
    
//
//    @Published var planets = [PlanetInfos]()
//
//    func fetchData(planetName: String) {
//        let name = "\(planetName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        let url = URL(string: "https://api.api-ninjas.com/v1/planets?name="+name!)!
//        var request = URLRequest(url: url)
//        request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
//        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//        }
//        task.resume()
//    }
//
    
    
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
