//
//  NetworkManager.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 01/02/23.
//

import Foundation
import SwiftUI

class NetworkManager: ObservableObject {
    
//    
//    // configura o cabeçalho com a key
//    let headers = [
//        "X-RapidAPI-Key": "2e68fe9a08msha4b151812270feep1fae83jsn67e1e76b4267",
//        "X-RapidAPI-Host": "planets-info-by-newbapi.p.rapidapi.com"
//    ]
//    // Solicita o requisição
//    let request = NSMutableURLRequest(url: NSURL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planet/list")! as URL,
//                                            cachePolicy: .useProtocolCachePolicy,
//                                        timeoutInterval: 10.0)
//
//    // Declara o tipo de requisição
//    request.httpMethod = "GET"
//    request.allHTTPHeaderFields = headers
//
//
//    // Faz a ligação com a API
//    let session = URLSession.shared
//    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//        guard let responseData = data else { return }
//        
//        do {
//            if let responseString = String(data: responseData, encoding: .utf8) {
//                print(responseString)
//            }
//        }
//    })
//
//    //aguarda o dado ser retornado
//    dataTask.resume()
}
