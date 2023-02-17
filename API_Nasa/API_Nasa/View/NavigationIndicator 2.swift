//
//  ARPlanetView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 14/02/23.
//
import ARKit
import SwiftUI

// MARK: - NavigationIndicator
struct NavigationIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARKitView
    @State var planetDetails: PlanetInfos
    
    func makeUIViewController(context: Context) -> ARKitView {
        return ARKitView(planetInfos: planetDetails)
    }
    func updateUIViewController(_ uiViewController:
                                NavigationIndicator.UIViewControllerType, context:
                                UIViewControllerRepresentableContext<NavigationIndicator>) { }
}

struct NavigationIndicatorView: View {
    @State var planetDetails: PlanetInfos
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            NavigationIndicator(planetDetails: planetDetails)
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
                        Text("Back")
                            .font(.custom(
                                "K2D-SemiBold",fixedSize: 18))
                    }.foregroundColor(Color.white)
                })
            }
        }
    }
}
