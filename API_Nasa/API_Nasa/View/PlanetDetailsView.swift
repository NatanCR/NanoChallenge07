//
//  PlanetDetailsView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 07/02/23.
//

import SwiftUI

struct PlanetDetailsView: View {
    
    @State var planetDetails: PlanetInfos
    var searchServices = InfosService()
    @Environment(\.dismiss) var dismiss
    
    //    init() {
    //        let navBarApperance = UINavigationBarAppearance()
    //        navBarApperance.backButtonAppearance =
    //    }
    
    func chooseShadowColor(id: Int) -> Color {
        switch id {
        case 1: return Color(red: 0.48, green: 0.47, blue: 0.47)
        case 2: return Color(red: 0.92, green: 0.90, blue: 0.89)
        case 3: return Color(red: 0.24, green: 0.47, blue: 0.77)
        case 4: return Color(red: 1.00, green: 0.53, blue: 0.38)
        case 5: return Color(red: 0.80, green: 0.63, blue: 0.49)
        case 6: return Color(red: 0.80, green: 0.67, blue: 0.45)
        case 7: return Color(red: 0.80, green: 0.88, blue: 0.93)
        case 8: return Color(red: 0.54, green: 0.65, blue: 0.84)
        default:
            return Color(.clear)
        }
    }
    
    var body: some View {
        VStack(alignment: .center){
            AsyncImage(url: URL(string: searchServices.percorrerImg(planets: [planetDetails])!)) { image in
                image
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 0)
                    }.shadow(color: chooseShadowColor(id: planetDetails.id),radius: 10)
            } placeholder: {
                ProgressView()
            }
            Text(planetDetails.name)
            Text(planetDetails.planetOrder)
            Text(planetDetails.description)
            Text(searchServices.searchMass(planetInfos: [planetDetails])!)
            Text(searchServices.searchVolume(planetInfos: [planetDetails])!)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                        Text("Back")
                    }.foregroundColor(Color.white)
                })
            }
        }
    }
    
}

//struct PlanetDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanetDetailsView()
//    }
//}
