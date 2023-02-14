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
    private var infosServices = InfosService()
    @State private var isActive: Bool = false
    
    //configura quantas colunas terá o grid e como serão
    private let columns = [GridItem(.flexible())]
    
    func refreshData() {
        Task {
            if !self.planetsWS.planetsService.isEmpty { return }
            do {
                try await self.planetsWS.loadData()
                self.isActive = true
            } catch {
                self.failedToLoadData.toggle()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView (showsIndicators: false){
                    if !isActive {
                        ProgressView("Loading...").padding(.top, 300)
                            .foregroundColor(.white)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                    ForEach(planetsWS.planetsService, id: \.id) { planet in
                        Cell(planetName: planet.name, imgURL: infosServices.searchImage(planets: [planet])!, planets: planet)
                    }
                }
            }
            .background(Image("estreladox3"))
            
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
            }.navigationBarTitle("Solar Wiki")
                .font(.custom(
                    "K2D-SemiBold",fixedSize: 18))
        }

        .environment(\.colorScheme, .dark)
        .task {
            if !self.planetsWS.planetsService.isEmpty { return }
            do {
                try await self.planetsWS.loadData()
                self.isActive = true
            } catch {
                self.failedToLoadData.toggle()
            }
        }
        .alert(isPresented: $failedToLoadData) {
            Alert(title: Text("Load failed"), message: Text("The connection server was lost"), primaryButton: .default(Text("Try again"), action: refreshData), secondaryButton: .cancel(Text("Cancel")))
        }
    }
}

