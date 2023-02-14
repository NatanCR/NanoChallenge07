//
//  LaunchScreen.swift
//  API_Nasa
//
//  Created by Guilherme Borges on 13/02/23.
//
import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                ZStack {
                    Color.init(red: 0, green: 0, blue: 0)
                    Image("planetaLogo")
                        .resizable()
                        .frame(width: 130, height: 130)
                        .scaleEffect(size)
                    }
                
        
       
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.3
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                        
                        }
                    }
                }
            }
        }
    }
