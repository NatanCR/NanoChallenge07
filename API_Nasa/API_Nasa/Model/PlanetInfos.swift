//
//  PlanetInfos.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation
//
//struct PlanetInfos:  Codable, Identifiable {
//    // MARK: - Welcome
//        let basicDetails: [BasicDetail]
//        let description: String
//        let id: Int
//        let imgSrc: [ImgSrc]
//        let key, name, planetOrder, source: String
//        let wikiLink: URL
//    }
//
//    // MARK: - BasicDetail
//    struct BasicDetail: Codable {
//        let mass, volume: String
//    }
//
//    // MARK: - ImgSrc
//    struct ImgSrc: Codable {
//        let img: String
//        let imgDescription: String
//    }
//

//Knowledge sharing

struct PlanetInfos:  Codable, Identifiable {
    // MARK: - Welcome
    let basicDetails: [BasicDetail]
    let description: String
    let id: Int
    let imgSrc: [ImgSrc]
    let key, name, planetOrder, source: String
    let wikiLink: URL
    
    static let planets: PlanetInfos = Bundle.main.decode(file: "planets.json")
    
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


extension Bundle {
    
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode from bundle.")
        }
        return loadedData
    }
}
