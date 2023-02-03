//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var planets = [PlanetInfos]()
    
    var body: some View {
        NavigationView {
            VStack {
                List(planets){
                    planets in
                    
                    Text("\(planets.name)")
                    Text("\(planets.description)")
                    Text("\(planets.imgSrc.description)")
                    AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/2/2b/Jupiter_and_its_shrunken_Great_Red_Spot.jpg")) { image in image.resizable()
                       
                    }placeholder: {
                        ProgressView()
                        
                    }.frame(width:200 , height: 200)
                }.padding().onAppear() {
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
