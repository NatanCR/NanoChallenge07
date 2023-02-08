//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var planetsWS = WebService()
    @State private var failedToLoadData: Bool = false
    private var searchServices = SearchServices()
    
    //configura quantas colunas terá o grid e como serão
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Image("estrelado")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                        .opacity(1)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(planetsWS.planetsService, id: \.id) { planet in
                                Cell(planetName: planet.name, imgURL: searchServices.percorrerImg(planets: [planet])!, planets: planet)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
//            .navigationBarTitle("Planets", displayMode: .inline)
        }
        .environment(\.colorScheme, .dark)
        .task {
            if !self.planetsWS.planetsService.isEmpty { return }
            
            do {
                try await self.planetsWS.loadData()
            } catch {
                print(error)
                print(error.localizedDescription)
                self.failedToLoadData.toggle()
            }
            print(self.planetsWS.planetsService)
        }
        .alert("Falha ao carregar as informações", isPresented: $failedToLoadData, actions: {Button(role: .cancel, action: {}, label: {Text("Ok")})}, message: {Text("Tente novamente mais tarde")})
    }
    
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }
}
