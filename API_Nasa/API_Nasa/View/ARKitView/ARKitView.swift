//
//  ARKitView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 14/02/23.
//

import Foundation
import ARKit
import SwiftUI

// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
   typealias UIViewControllerType = ARKitView
    @State var planetDetails: PlanetInfos
   
   func makeUIViewController(context: Context) -> ARKitView {
       return ARKitView(planetInfos: planetDetails) //cria o estado inicial da visualização e retorna
   }
   func updateUIViewController(_ uiViewController:
   ARViewIndicator.UIViewControllerType, context:
   UIViewControllerRepresentableContext<ARViewIndicator>) { } //atualiza o estado da visualização
}

class ARKitView: UIViewController, ARSCNViewDelegate {
    var planetInfos: PlanetInfos
    
    init(planetInfos: PlanetInfos) {
        self.planetInfos = planetInfos //inicializa a variável para não ser vazia
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //tratamento de erro
    }
    
    var arView: ARSCNView {
        return self.view as! ARSCNView //cria uma cena arkit e aloca na variável
    }
    override func loadView() {
        self.view = ARSCNView(frame: .zero) //carrega a cena
    }
    
    
    override func viewDidLoad() { //inicializa a view
        super.viewDidLoad()
        arView.delegate = self
        arView.scene = SCNScene()
        createPlanetSphere()
    }
    
    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
       }
    
    override func viewWillAppear(_ animated: Bool) { //configura a cena
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal //utiliza plano horizontal na criação dos nodes

        // Run the view's session
        arView.session.run(configuration)
        arView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        arView.session.pause() //pausa a sessão quando sai da view
    }
    
    func createPlanetSphere() { // cria a esfera do planeta
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(planetInfos.name).jpeg")
        sphere.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(0, 0.1, -0.5)
        node.geometry = sphere
        arView.scene.rootNode.addChildNode(node)
        addAnimation(node: node)
        arView.automaticallyUpdatesLighting = true
        
    }
    
    func addAnimation(node: SCNNode) { //faz a rotação do node
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
    
}
