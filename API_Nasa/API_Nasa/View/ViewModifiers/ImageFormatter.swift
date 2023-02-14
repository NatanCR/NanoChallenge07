//
//  ImageFormatter.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 10/02/23.
//

import SwiftUI

struct ImageFormatter: View {
    var imgURL: String
    
    var body: some View {
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
    }
}
