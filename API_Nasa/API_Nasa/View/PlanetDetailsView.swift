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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 5){
            ImageFormatter(imgURL: infosServices.searchImage(planets: [planetDetails])!)
                .shadow(color: infosServices.chooseShadowColor(id: planetDetails.id),radius: 10)
                .padding(.bottom, 20)
            Section() {
                ScrollView(){
                    DetailCell(text: planetDetails.name, title: "Planet name: ")
                    DetailCell(text: planetDetails.planetOrder, title: "Solar system order: ")
                    Text("Planet description: " + planetDetails.description)
                        .font(.custom("K2D-Regular",fixedSize: 18))
                        .multilineTextAlignment(.leading).padding(10)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                                .opacity(0.4)
                        }
                        .padding(.horizontal)
                    DetailCell(text: infosServices.searchMass(planetInfos: [planetDetails])!, title: "Planet mass: ")
                    DetailCell(text: infosServices.searchVolume(planetInfos: [planetDetails])!, title: "Planet volume: ")
                    DetailCell(text: "\(Int(infosServices.searchPeriod(planets: [planetDetails]) ?? 00))", title: "Time to orbit sun in Earth days:")
                    DetailCell(text: "\(String(format: "%.1f", infosServices.searchTemperature(planetsTemp: [planetDetails]) ?? 0)) ºC", title: "Core temperature: ")
                    DetailCell(text: "\(Int(infosServices.getStarHost(StarHost: [planetDetails]) ?? 00))", title: "Host star: " )
                    DetailCell(text: "\(Double(infosServices.getStarTemp(StarHost: [planetDetails]) ?? 00)) ºC", title: "Sun photosphere: " )
                }
            } header: {
                Text("Information:")
                    .font(.custom(
                        "K2D-SemiBold",fixedSize: 24))
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
                            .font(.custom(
                                "K2D-SemiBold",fixedSize: 18))
                    }.foregroundColor(Color.white)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    NavigationIndicatorView(planetDetails: planetDetails)
                } label: {
                    Label {
                        Text("")
                    }icon: {
                        Image(systemName: "arkit").foregroundColor(.white)
                    }
                }

            }
        }
//        .task {
//            if !self.planetsWS.planetPlusService.isEmpty { return }
//            do {
//                try await self.planetsWS.loadPlusData(planetName: planetDetails.name)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
}
