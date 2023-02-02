//
//  ContentView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var planetsInfosViewModel = PlanetInfosViewModel()
    
    var body: some View {
        NavigationView {
                List {
                    
                    ForEach(planetsInfosViewModel.planets, id: \.id) { planet in
                        Text(planet.name)
                            .font(.system(size: 19, weight: .bold, design: .rounded))
                            .foregroundColor(Color.init(red: 0.00, green: 0.16, blue: 0.35, opacity: 1.00))
                    }
                }
                .navigationBarTitle("Planetas")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
