//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var planetsWS: WebService
    var searchServices = SearchServices()
    
    
    //configura quantas colunas terá o grid e como serão
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("estrelado")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .opacity(1)
                
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(planetsWS.planetsService, id: \.id) { planet in
                                Cell(planetName: planet.name, imgURL: searchServices.percorrerImg(planets: [planet])!, planets: planet)
                            }
                        }
                    }
                    .navigationBarTitle("Planets", displayMode: .inline)
                    .background(Image("estrelado"))
                    .padding(.top)
                }
            }
        }
        .environment(\.colorScheme, .dark)
    }
    
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }
}
