//
//  DetailCell.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 09/02/23.
//

import SwiftUI

struct DetailCell: View {
    var text: String
    
    var body: some View {
        Text(text)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                    .opacity(0.4)
            }
            .padding(.horizontal)
    }
}

//struct DetailCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCell()
//    }
//}
