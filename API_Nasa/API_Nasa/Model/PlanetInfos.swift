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

struct PlanetInfos: Codable, Identifiable {
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
    let mass, volume : String
    let period: Double
    let temperature: Double
    let host_star_mass, host_star_temperature: Double
}


// MARK: - ImgSrc
struct ImgSrc: Codable {
    let img: String
    let imgDescription: String
}


