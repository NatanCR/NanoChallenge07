//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    private var planetsWS = WebService()
    @State private var failedToLoadData: Bool = false
    private var infosServices = InfosService()
    @State private var isActive: Bool = false
    @State private var showInfo: Bool = false
    
    //configura quantas colunas terá o grid e como serão
    private let columns = [GridItem(.flexible())]
    
    func refreshData() {
        Task {
            if !self.planetsWS.planetsService.isEmpty { return }
            do {
                self.isActive = true
                try await self.planetsWS.load(filename: "planets.json")
            } catch {
                self.failedToLoadData.toggle()
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { scroll in
                    ScrollView (showsIndicators: false) {
                        if !isActive {
                            ProgressView("load").padding(.top, 300)
                                .foregroundColor(.white)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                        VStack {
                            ForEach(planetsWS.planetsService, id: \.name) { planet in
                                Cell(planetName: planet.name, imgURL: infosServices.searchImage(planets: [planet])!, planets: planet)
                            }
                        }.padding(.bottom, 40)
                        Button {
                            self.showInfo.toggle()
                        } label: {
                            Image(systemName: "info.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        if showInfo {
                            Text("i")
                                .font(.custom("K2D-Regular",fixedSize: 18))
                                .padding()
                                .onAppear {
                                    withAnimation {
                                        scroll.scrollTo("info", anchor: .bottom) // rola a scrollView para o ID do Text
                                    }
                                }
                                .id("info") // define o ID do Text como "info"
                        }
                    }
                }
            }
            .background(Image("estrelado"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu{
                        Text("order")
                        Button {
                            planetsWS.order(planet: planetsWS.planetsService, chave: "id")
                            print(planetsWS.planetsService)
                        } label: {
                            Label(title:{Text("solar")}, icon: {})
                        }
                        Button {
                            planetsWS.order(planet: planetsWS.planetsService, chave: "name")
                            print(planetsWS.planetsService)
                        } label: {
                            Label(title:{Text("name")}, icon: {})
                        }
                    }label: {
                        Label {
                            Text("")
                        } icon: {
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
                try await self.planetsWS.load(filename: "planets.json")
                self.isActive = true
            } catch {
                self.failedToLoadData.toggle()
            }
        }
        .alert(isPresented: $failedToLoadData) {
            Alert(title: Text("loadFailed"), message: Text("server"), primaryButton: .default(Text("try"), action: refreshData), secondaryButton: .cancel(Text("cancel")))
        }
    }
}

