//
//  NetworkManager.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 01/02/23.
//

import Foundation

class NetworkManager {
    
    func fetchData(planetName: String) {
        if let url = URL(string: "xxxxx\(planetName)xxxxx") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder() //decodifica os dados recuperados da sessão de rede
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData) //obtem os dados da API
                            DispatchQueue.main.async { //prioriza na primeira thread
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
}
