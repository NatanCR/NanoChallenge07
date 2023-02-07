//
//  API_NasaApp.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 31/01/23.
//

import SwiftUI

@main
struct API_NasaApp: App {
    var data = WebService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(planetsWS: data)
                .onAppear() {
                    WebService().loadData{
                        (planets) in self.data.planetsService = planets
                    }
                }
        }
    }
}
