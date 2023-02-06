//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var planets = [PlanetInfos]()
    
    init(){
        Theme.navigationBarColors(background: .black, titleColor: .white)
        }
    
    func percorrerImg (planets: [PlanetInfos]) -> String? {
        for i in planets {
            for j in i.imgSrc {
                let link = j.img
                return link
            }
        }
        return nil
    }
    
    var body: some View {
        NavigationView {
            if #available(iOS 16.0, *) {
                VStack {
                    List(planets){ planets in
                        Cell(planetName: planets.name, imgURL: percorrerImg(planets: [planets])!)
                            .listRowBackground(Color.black)
                    }
                    .onAppear() {
                        WebService().loadData{
                            (planets) in self.planets = planets
                        }
                    }
                }
                .navigationBarTitle("Planets", displayMode: .inline)
                .toolbarColorScheme(.dark, for: .navigationBar)
            } else {
                // Fallback on earlier versions
                VStack {
                    List(planets){ planets in
                        Cell(planetName: planets.name, imgURL: percorrerImg(planets: [planets])!)
                            .listRowBackground(Color.black)
                    }
                    .onAppear() {
                        WebService().loadData{
                            (planets) in self.planets = planets
                        }
                    }
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
