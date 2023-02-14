//
//  Cell.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 03/02/23.
//

import SwiftUI

struct Cell: View {
    var planetName, imgURL: String
    @State private var isActive = false
    @State var planets: PlanetInfos
    
    var body: some View {
        VStack(alignment: .center) {
          ImageFormatter(imgURL: imgURL)
                    .onTapGesture {
                    self.isActive = true
                }
                .background(
                    NavigationLink(destination: PlanetDetailsView(planetDetails: planets), isActive: $isActive, label: {
                        EmptyView()
                    }))
            
            Text(planetName)
                .font(.custom(
                    "K2D-SemiBold",fixedSize: 19))
                .foregroundColor(Color.white)
        }.padding(.top, 50)
    }
}


  
