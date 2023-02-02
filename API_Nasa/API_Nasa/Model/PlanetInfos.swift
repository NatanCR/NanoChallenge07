//
//  PlanetInfos.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation

struct PlanetInfos: Decodable, Identifiable {
    let basicDetails: BasicDetails
    let description: String
    let id: Int
    let imgSrc: ImgSrc
    let key: String
    let name: String
    let planetOrder: String
}

struct ImgSrc: Decodable {
    let img: String
    let imgDescription: String
}

struct BasicDetails: Decodable {
    let mass: String
    let volume: String
}
