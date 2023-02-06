//
//  Cell.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 03/02/23.
//

import SwiftUI

struct Cell: View {
    
    var planetName, imgURL: String
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: imgURL)) { image in
                    image
                        .resizable()
//                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                }placeholder: {
                    ProgressView()
                }
                Text(planetName)
                    .font(.system(size: 19, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
            }.padding(.bottom, 40)
        }
    }
}
