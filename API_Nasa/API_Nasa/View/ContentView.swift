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
    //configura quantas colunas terá o grid e como serão
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
   
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(planets, id: \.id) { planet in
                    Cell(planetName: planet.name, imgURL: percorrerImg(planets: [planet])!)
                    
//                    AsyncImage(url: URL(string: percorrerImg(planets: [planet])!)) { image in
//                        image
//                            .resizable()
////                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 350, height: 350)
//                            .clipShape(Circle())
//                    }placeholder: {
//                        ProgressView()
//                    }
//                    Text(planet.name)
//                        .foregroundColor(Color.black)
//                        .padding(.vertical)
                }
            }
            .onAppear() {
                WebService().loadData{
                    (planets) in self.planets = planets
                }
            }
        }
        
        
//        NavigationView {
//            if #available(iOS 16.0, *) {
//                VStack {
//                    List(planets){ planets in
//                        Cell(planetName: planets.name, imgURL: percorrerImg(planets: [planets])!)
//                            .listRowBackground(Color.black)
//                    }
//                    .onAppear() {
//                        WebService().loadData{
//                            (planets) in self.planets = planets
//                        }
//                    }
//                }
//                .navigationBarTitle("Planets", displayMode: .inline)
//                .toolbarColorScheme(.dark, for: .navigationBar)
//            } else {
//                // Fallback on earlier versions
//
//            }
//        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
