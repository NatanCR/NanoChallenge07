//
//  DetailCell.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 09/02/23.
//

import SwiftUI

struct DetailCell: View {
    var text: String
    var title: Text
    
    var body: some View {
        HStack{
            title
                .font(.custom(
                "K2D-SemiBold",fixedSize: 18))
            Text(text)
                .font(.custom("K2D-Regular",fixedSize: 18))
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                .opacity(0.4)
        }
        .padding(.horizontal)
    }
}
