//
//  PlanetDetailsView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 07/02/23.
//

import SwiftUI

struct PlanetDetailsView: View {
    @StateObject var planetsWS = WebService()
    @State var planetDetails: PlanetInfos
    var searchServices = InfosService()
    @Environment(\.dismiss) var dismiss
    
    //    init() {
    //        let navBarApperance = UINavigationBarAppearance()
    //        navBarApperance.backButtonAppearance =
    //    }
    
    func chooseShadowColor(id: Int) -> Color {
        switch id {
        case 1: return Color(red: 0.48, green: 0.47, blue: 0.47)
        case 2: return Color(red: 0.92, green: 0.90, blue: 0.89)
        case 3: return Color(red: 0.24, green: 0.47, blue: 0.77)
        case 4: return Color(red: 1.00, green: 0.53, blue: 0.38)
        case 5: return Color(red: 0.80, green: 0.63, blue: 0.49)
        case 6: return Color(red: 0.80, green: 0.67, blue: 0.45)
        case 7: return Color(red: 0.80, green: 0.88, blue: 0.93)
        case 8: return Color(red: 0.54, green: 0.65, blue: 0.84)
        default:
            return Color(.clear)
        }
    }
    
    var body: some View {
        
        
            VStack(spacing: 5){
                AsyncImage(url: URL(string: searchServices.percorrerImg(planets: [planetDetails])!)) { image in
                    image
                        .resizable()
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 0)
                        }.shadow(color: chooseShadowColor(id: planetDetails.id),radius: 10)
                } placeholder: {
                    ProgressView()
                }
                .padding(.bottom, 20)
                
                Section {
                    
                } header: {
                    Text("Information:")
                        .font(.title)
                }
//                .padding(.trailing, 200)
                .padding(.bottom, 10)
                
                ScrollView(){
                Text("Name: \(planetDetails.name)")
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                            .opacity(0.4)
                    }
                    .padding(.horizontal)

                Text("Planet order: " + planetDetails.planetOrder)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                            .opacity(0.4)
                    }
                    .padding(.horizontal)
                
                Text("Description: " + planetDetails.description)
                    .multilineTextAlignment(.leading).padding(10)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                            .opacity(0.4)
                    }
                    .padding(.horizontal)
                
                Text("Planet Mass: "  + searchServices.searchMass(planetInfos: [planetDetails])!)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                            .opacity(0.4)
                    }
                    .padding(.horizontal)
                
                Text("Planet Volume: "  + searchServices.searchVolume(planetInfos: [planetDetails])!)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.init(red: 0.26, green: 0.26, blue: 0.26, alpha: 1.00)))
                            .opacity(0.4)
                    }
                    .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                dismiss()
                            }, label: {
                                HStack {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                                    Text("Back")
                                }.foregroundColor(Color.white)
                            })
                        }
                    }

        }
    }
    
}

//struct PlanetDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlanetDetailsView()
//    }
//}
