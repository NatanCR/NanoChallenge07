//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var planets = [PlanetInfos]()
    
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
            VStack {
                List(planets){
                    planets in
                    
                    Text("\(planets.name)")
                    AsyncImage(url: URL(string: percorrerImg(planets: [planets])!)) { image in image.resizable().frame(width:350 , height: 350)
                        
                    }placeholder: {
                        ProgressView()
                        
                    }
                    //                    Text("\(planets.description)")
                    
                    
                }
                .onAppear() {
                    WebService().loadData{
                        (planets) in self.planets = planets
                    }
                }
            }
            
            .navigationTitle("Planetas")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
