////
////  PlanetInfos.swift
////  API_Nasa
////
////  Created by Natan de Camargo Rodrigues on 02/02/23.
////
//
//import Foundation
//
////"basicDetails":[
////     {
////        "mass":"5.6834 x 10^26 kg",
////        "volume":"8.2713 x 10^14 km^3"
////     }
////  ],
////  "description":"Saturn is the sixth planet from the Sun and the second-largest in the Solar System, after Jupiter. It is a gas giant with an average radius of about nine and a half times that of Earth. It has only one-eighth the average density of Earth; however, with its larger volume, Saturn is over 95 times more massive.",
////  "id":6,
////  "imgSrc":[
////     {
////        "img":"https://upload.wikimedia.org/wikipedia/commons/c/c7/Saturn_during_Equinox.jpg",
////        "imgDescription":"Pictured in natural color approaching equinox, photographed by Cassini in July 2008; the dot in the bottom left corner is Titan."
////     }
////  ],
////  "key":"45l1h8dab43b",
////  "name":"Saturn",
////  "planetOrder":"6",
////  "source":"Wikipedia",
////  "wikiLink":"https://en.wikipedia.org/wiki/Saturn"
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
//        let img: URL
//        let imgDescription: String
//    }
//
