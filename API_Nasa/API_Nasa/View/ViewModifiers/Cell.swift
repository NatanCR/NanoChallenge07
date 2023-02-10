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
                .statusBarHidden(true)
                    .onTapGesture {
                    self.isActive = true
                }
                .background(
                    NavigationLink(destination: PlanetDetailsView(planetDetails: planets), isActive: $isActive, label: {
                        EmptyView()
                    }))
            
            Text(planetName)
                .font(.system(size: 19, weight: .bold, design: .rounded))
                .foregroundColor(Color.white)
        }.padding(.top, 50)
    }
}


  
