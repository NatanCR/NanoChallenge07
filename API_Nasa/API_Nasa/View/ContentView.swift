//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    @State var alertPlanet = true
    
    @StateObject var planetsWS = WebService()
    @State private var failedToLoadData: Bool = false
    private var searchServices = InfosService()
    
    //configura quantas colunas terá o grid e como serão
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView (showsIndicators: false){
                    ForEach(planetsWS.planetsService, id: \.id) { planet in
                        Cell(planetName: planet.name, imgURL: searchServices.percorrerImg(planets: [planet])!, planets: planet)
                        
                    }
                }
               
            }.background(Image("estrelado"))
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Text("Order By:")
                        Button {
                            planetsWS.order(planet: planetsWS.planetsService, chave: "id")
                        } label: {
                            Label(title:{Text("Solar System")}, icon: {})
                        }
                        Button {
                            planetsWS.order(planet: planetsWS.planetsService, chave: "name")
                        } label: {
                            Label(title:{Text("Name")}, icon: {})
                        }
                    }label: {
                        Label {
                            Text("")
                        }icon: {
                            Image(systemName: "line.3.horizontal.decrease.circle.fill").foregroundColor(.white)
                        }
                    }
                    
                }
            }.navigationBarTitle("Planets")
        }
//        .alert("Planets are displayed by default in solar system order relative to the sun", isPresented: $alertPlanet, actions: {Button(role: .cancel, action: {}, label: {Text("Ok")})})
        
        .environment(\.colorScheme, .dark)
        .task {
            if !self.planetsWS.planetsService.isEmpty { return }
            do {
                try await self.planetsWS.loadData()
            } catch {
             
                self.failedToLoadData.toggle()
            }
        }
        .alert("Falha ao carregar as informações", isPresented: $failedToLoadData, actions: {Button(role: .cancel, action: {}, label: {Text("Ok")})}, message: {Text("Tente novamente mais tarde")})
    }

    
    

    }

