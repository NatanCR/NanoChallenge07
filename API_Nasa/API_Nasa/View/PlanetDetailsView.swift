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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 5){
                ImageFormatter(imgURL: InfosService.searchImage(planets: [planetDetails])!)
                    .shadow(color: Color(uiColor: InfosService.chooseShadowColor(id: planetDetails.id)),radius: 10)
                    .padding(.bottom, 20)
            Section() {
                ScrollView(){
                    DetailCell(text: planetDetails.name, title: Text("planetName"))
                    DetailCell(text: planetDetails.planetOrder, title: Text("planetOrder"))
                    VStack {
                        HStack {
                            Text("planetDescription")
                                .font(.custom("K2D-SemiBold", fixedSize: 18)) +
                            Text(planetDetails.description)
                                .font(.custom("K2D-Regular", fixedSize: 18))
                        }
                        .multilineTextAlignment(.leading)
                        .padding(10)
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                                    .opacity(0.4)
                            }
                    }
                        .padding(.horizontal)

                    DetailCell(text: InfosService.searchMass(planetInfos: [planetDetails])!, title: Text("mass"))
                    DetailCell(text: InfosService.searchVolume(planetInfos: [planetDetails])!, title: Text("volume"))
                    DetailCell(text: "\(Int(InfosService.searchPeriod(planets: [planetDetails]) ?? 00)) \(NSLocalizedString("day", comment: ""))", title: Text("time"))
                    DetailCell(text: "\(String(format: "%.1f", InfosService.searchTemperature(planetsTemp: [planetDetails]) ?? 0)) ºC", title: Text("core"))
                    DetailCell(text: "\(Int(InfosService.getStarHost(StarHost: [planetDetails]) ?? 00))", title: Text("host"))
                    DetailCell(text: "\(Double(InfosService.getStarTemp(StarHost: [planetDetails]) ?? 00)) ºC", title: Text("sun"))
                }
            } header: {
                Text("info")
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
                        Text("back")
                            .font(.custom(
                                "K2D-SemiBold",fixedSize: 18))
                    }.foregroundColor(Color.white)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    NavigationIndicatorView(planetInfos: planetDetails)
                } label: {
                    Label {
                        Text("")
                    }icon: {
                        Image(systemName: "arkit").foregroundColor(.white)
                    }
                }

            }
        }
    }
}
