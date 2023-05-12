//
//  SearchServices.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 07/02/23.
//

import Foundation
import SwiftUI

class InfosService {
    
    func getStarHost(StarHost: [PlanetInfos]) -> Double? {
        for host in StarHost {
            for j in host.basicDetails {
                let sun = j.host_star_mass
                return sun
            }
           
        }
        return nil
    }
    
    func getStarTemp(StarHost: [PlanetInfos]) -> Double? {
        for host in StarHost {
            for j in host.basicDetails {
                let sun = j.host_star_temperature
                return sun
            }
           
        }
        return nil
    }
    
    func searchTemperature(planetsTemp: [PlanetInfos]) -> Double? {
        for i in planetsTemp {
            for j in i.basicDetails {
                let temp = (Double(j.temperature) - 32 ) / 1.8
                
                return temp
            }
          
        }
        return nil
    }
    
    func searchPeriod(planets: [PlanetInfos]) -> Double? {
        for i in planets {
            for j in i.basicDetails{
                let period = j.period
                
                 return period
            }
           
        }
        return nil
    }
    
    func searchImage(planets: [PlanetInfos]) -> String? {
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
    
    func chooseShadowColor(id: Int) -> UIColor {
        switch id {
        case 0: return UIColor(red: 0.97, green: 0.42, blue: 0.01, alpha: 1)
        case 1: return UIColor(red: 0.48, green: 0.47, blue: 0.47, alpha: 1)
        case 2: return UIColor(red: 0.92, green: 0.90, blue: 0.89, alpha: 1)
        case 3: return UIColor(red: 0.24, green: 0.47, blue: 0.77, alpha: 1)
        case 4: return UIColor(red: 1.00, green: 0.53, blue: 0.38, alpha: 1)
        case 5: return UIColor(red: 0.80, green: 0.63, blue: 0.49, alpha: 1)
        case 6: return UIColor(red: 0.80, green: 0.67, blue: 0.45, alpha: 1)
        case 7: return UIColor(red: 0.80, green: 0.88, blue: 0.93, alpha: 1)
        case 8: return UIColor(red: 0.54, green: 0.65, blue: 0.84, alpha: 1)
        default:
            return UIColor.clear
        }
    }
}
