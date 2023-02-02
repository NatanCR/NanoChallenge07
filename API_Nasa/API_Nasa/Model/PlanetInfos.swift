//
//  PlanetInfos.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 02/02/23.
//

import Foundation

struct PlanetInfos: Decodable, Identifiable {
    let id: Int
    let name: String
    let mass: Double
    let period: Double
    let temperature: Double
}
