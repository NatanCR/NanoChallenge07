//
//  SearchServices.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 07/02/23.
//

import Foundation

class SearchServices {
    func percorrerImg (planets: [PlanetInfos]) -> String? {
        for i in planets {
            for j in i.imgSrc {
                let link = j.img
                return link
            }
        }
        return nil
    }
    
    func searchMass(planetInfos: [PlanetInfos]) -> String? {
        var mass: String
        
        for i in planetInfos {
            for j in i.basicDetails {
                mass = j.mass
                return mass
            }
        }
        return nil
    }
    
    func searchVolume(planetInfos: [PlanetInfos]) -> String? {
        var volume: String
        
        for i in planetInfos {
            for j in i.basicDetails {
                volume = j.volume
                return volume
            }
        }
        return nil
    }
}
