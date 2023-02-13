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
//    @State var planetPlusDetaisl: [PlusPlanetInfos]
    
    var body: some View {
        VStack(spacing: 5){
            ImageFormatter(imgURL: infosServices.searchImage(planets: [planetDetails])!)
                .shadow(color: infosServices.chooseShadowColor(id: planetDetails.id),radius: 10)
                .padding(.bottom, 20)
            
            Section {
                ScrollView(){
                    DetailCell(text: "Planet name: " + planetDetails.name)
                    DetailCell(text: "Solar system order: " + planetDetails.planetOrder)
                    
                    Text("Planet description: " + planetDetails.description)
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
                    DetailCell(text: "Time to orbit sun in Earth days : \(Int(infosServices.searchPeriod(planets: planetsWS.planetPlusService.self) ?? 0))")
                    
                    DetailCell(text: "Core temperature: \(String(format: ": %.1f", infosServices.searchTemperature(planetsTemp: planetsWS.planetPlusService.self  ) ?? 0)) ºC")
                    DetailCell(text: "Host star: \(infosServices.getStarHost(StarHost: planetsWS.planetPlusService.self) ?? 00)" )
                    DetailCell(text: "Star photosphere tempereture: \(Double(infosServices.getStarTemp(StarHost: planetsWS.planetPlusService.self) ?? 00)) ºC" )
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
        .task {
            if !self.planetsWS.planetPlusService.isEmpty { return }
            do {
                try await self.planetsWS.loadPlusData(planetName: planetDetails.name)
//                try await print(planetsWS.planetPlusService.)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}

//struct PlanetDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanetDetailsView()
//    }
//}
