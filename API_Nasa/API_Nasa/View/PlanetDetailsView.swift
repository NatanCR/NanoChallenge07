//
//  PlanetDetailsView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 07/02/23.
//

import SwiftUI

struct PlanetDetailsView: View {
    @StateObject var planetsWS = WebService()
    @State var planetDetails: PlanetInfos
    var infosServices = InfosService()
    @Environment(\.dismiss) var dismiss
    
   
    
    var body: some View {
        VStack(spacing: 5){
            AsyncImage(url: URL(string: infosServices.percorrerImg(planets: [planetDetails])!)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                    .cornerRadius(100)
//                    .overlay {
//                        Circle().stroke(.white, lineWidth: 0)
//                    }
                    .shadow(color: infosServices.chooseShadowColor(id: planetDetails.id),radius: 10)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 20)
            
            Section {
                ScrollView(){
                    DetailCell(text: "Name: " + planetDetails.name)
                    DetailCell(text: "Planet order: " + planetDetails.planetOrder)
                    
                    Text("Description: " + planetDetails.description)
                        .multilineTextAlignment(.leading).padding(10)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                                .opacity(0.4)
                        }
                        .padding(.horizontal)
                    
                    DetailCell(text: "Planet mass: " + infosServices.searchMass(planetInfos: [planetDetails])!)
                    DetailCell(text: "Planet volume: " + infosServices.searchVolume(planetInfos: [planetDetails])!)
                }
            } header: {
                Text("Information:")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 20)
            }
            .padding(.bottom, 10)
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
