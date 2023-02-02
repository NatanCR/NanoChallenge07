//
//  PlanetInfos.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation
import Combine

class PlanetInfosViewModel: ObservableObject {
    
    init() {
        fetchPost()
    }
    
    @Published var planets = [PlanetInfos]()
     
    let webService = WebService()
    
    private func fetchPost() {
        webService.getAll() {
            if $0 != nil {
                self.planets = $0!
            }
        }
    }
}

extension Array where Element : Identifiable{
    func firstIndexOf (of item: Element) -> Int?{
        for index in 0..<self.count {
            if self[index].id == item.id {
                return index
            }
        }
        
        return nil
    }
}
