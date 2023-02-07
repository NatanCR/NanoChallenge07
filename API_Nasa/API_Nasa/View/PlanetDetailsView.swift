//
//  PlanetDetailsView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 07/02/23.
//

import SwiftUI

struct PlanetDetailsView: View {
    
    @State var planetDetails: PlanetInfos
//    @StateObject var webService: WebService
    var searchServices = SearchServices()
            
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                AsyncImage(url: URL(string: searchServices.percorrerImg(planets: [planetDetails])!)) { image in
                    image
                        .resizable()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
                Text(planetDetails.name)
                Text(planetDetails.planetOrder)
                Text(planetDetails.description)
                Text(searchServices.searchMass(planetInfos: [planetDetails])!)
                Text(searchServices.searchVolume(planetInfos: [planetDetails])!)
            }
            
        }
    }
}

//struct PlanetDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanetDetailsView()
//    }
//}
