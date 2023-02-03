//
//  WebService.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation
import SwiftUI

struct PlanetInfos:  Codable, Identifiable {
    // MARK: - Welcome
        let basicDetails: [BasicDetail]
        let description: String
        let id: Int
        let imgSrc: [ImgSrc]
        let key, name, planetOrder, source: String
        let wikiLink: URL
    }

    // MARK: - BasicDetail
    struct BasicDetail: Codable {
        let mass, volume: String
    }

    // MARK: - ImgSrc
    struct ImgSrc: Codable {
        let img: String
        let imgDescription: String
    }


class WebService: ObservableObject {
    @Published var planets = [PlanetInfos]()
    
    func loadData(completion: @escaping ([PlanetInfos]) -> ()) {
        
       
        
        //        let headers = [
        //            "X-RapidAPI-Key": "2e68fe9a08msha4b151812270feep1fae83jsn67e1e76b4267",
        //            "X-RapidAPI-Host": "planets-info-by-newbapi.p.rapidapi.com"
        //        ]
        //        // Solicita o requisição
        //        let request = NSMutableURLRequest(url: NSURL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list")! as URL,
        //                                                cachePolicy: .useProtocolCachePolicy,
        //                                            timeoutInterval: 10.0)
        //
        //        // Declara o tipo de requisição
        //        request.httpMethod = "GET"
        //        request.allHTTPHeaderFields = headers
        
        
        // Faz a ligação com a API
        guard let url = URL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list") else {
            print("invalid url..")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("2e68fe9a08msha4b151812270feep1fae83jsn67e1e76b4267", forHTTPHeaderField: "X-RapidAPI-Key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let planets = try! JSONDecoder().decode([PlanetInfos].self, from: data!)
            print(planets)
            DispatchQueue.main.async {
                completion(planets)
            }
        }.resume()
    }
}


//    let session = URLSession.shared
//
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error  in
//
//        guard let data = data, error == nil else {
//            return
//        }
//
//
//        var result: [PlanetInfos]?
//
//        do {
//            result = try JSONDecoder().decode([PlanetInfos].self , from: data)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
//        guard let json = result else { return }
//
//        print(json)
//
//    })
//    dataTask.resume()
//}
