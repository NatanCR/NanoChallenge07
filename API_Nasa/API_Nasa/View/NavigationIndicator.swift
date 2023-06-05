//
//  ARPlanetView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 14/02/23.
//
import SwiftUI

struct NavigationIndicatorView: View {
    @State var planetInfos: PlanetInfos
    @Environment(\.dismiss) private var dismiss
    @State private var colorButton: Color = .white
    
    var body: some View {
        ZStack {
            ARViewIndicator(planetInfos: planetInfos)
        }
        .ignoresSafeArea(.all)
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
        }
    }
}
