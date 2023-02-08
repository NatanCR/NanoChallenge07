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
            ZStack {
                AsyncImage(url: URL(string: imgURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .cornerRadius(100)

                } placeholder: {
                    ProgressView()
                }
                Circle()
                    .opacity(0.01)
                    .frame(width: 250, height: 250)
                    .onTapGesture {
                    self.isActive = true
                }
                .background(
                    NavigationLink(destination: PlanetDetailsView(planetDetails: planets), isActive: $isActive, label: {
                        EmptyView()
                    }))
            }
            Text(planetName)
                .font(.system(size: 19, weight: .bold, design: .rounded))
                .foregroundColor(Color.white)
        }.padding(.bottom, 40)
    }
}


  
