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
        //cria o estado inicial da visualização e retorna
        return ARKitView(planetInfos: planetDetails)
    }
    func updateUIViewController(_ uiViewController:
                                ARViewIndicator.UIViewControllerType, context:
                                //atualiza o estado da visualização
                                UIViewControllerRepresentableContext<ARViewIndicator>) { }
}

class ARKitView: UIViewController, ARSCNViewDelegate {
    var planetInfos: PlanetInfos
    var planetNode = SCNNode()
    var lastPosition: CGPoint?
    var currentLanguage = Locale.current
    var lastScale = SCNVector3(1.0, 1.0, 1.0)
    
    init(planetInfos: PlanetInfos) {
        self.planetInfos = planetInfos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        //tratamento de erro
        fatalError("init(coder:) has not been implemented")
    }
    
    //variável referência da view
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        arView.session.run(configuration)
        arView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        arView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
        arView.scene = SCNScene()
        createPlanetSphere()
//        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
//        arView.addGestureRecognizer(pinchGesture)
    }
    
//    @objc func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
//        guard let sceneView = gestureRecognizer.view as? ARSCNView else { return }
//
//        // Verifica se o gesto começou
//        if gestureRecognizer.state == .began {
//            // Salva a escala atual do nó
//            lastScale = planetNode.scale
//            return
//        }
//
//        // Verifica se o gesto está em andamento
//        if gestureRecognizer.state == .changed {
//            // Calcula a nova escala baseada na escala atual e no fator de escala do gesto
//            var newScale = SCNVector3(
//                lastScale.x * Float(gestureRecognizer.scale),
//                lastScale.y * Float(gestureRecognizer.scale),
//                lastScale.z * Float(gestureRecognizer.scale)
//            )
//
//            // Limita a escala mínima e máxima do nó para evitar distorções
//            let minScale: Float = 0.1
//            let maxScale: Float = 3.0
//            newScale.x = max(min(newScale.x, maxScale), minScale)
//            newScale.y = max(min(newScale.y, maxScale), minScale)
//            newScale.z = max(min(newScale.z, maxScale), minScale)
//
//            // Aplica a nova escala ao nó
//            planetNode.scale = newScale
//
//            // Reseta o fator de escala do gesto para 1.0 para garantir um comportamento consistente
//            gestureRecognizer.scale = 1.0
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Obtém a localização do toque atual
        guard let currentTouchLocation = touches.first?.location(in: arView) else { return }
        
        // Salva a posição do toque atual
        lastPosition = currentTouchLocation
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Obtém a localização do toque atual
        guard let currentTouchLocation = touches.first?.location(in: arView) else { return }
        
        // Verifica se a posição anterior do toque é conhecida
        guard let lastPosition = lastPosition else { return }
        
        // Calcula a diferença de posição entre o toque anterior e o toque atual
        let deltaX = Float(currentTouchLocation.x - lastPosition.x)
        let deltaY = Float(currentTouchLocation.y - lastPosition.y)
        
        // Calcula a rotação a ser aplicada
        let sensitivityFactor: Float = 8.0
        let rotationX = simd_float3(0, 1, 0) * (deltaX * (Float.pi / 180) / sensitivityFactor)
        let rotationY = simd_float3(1, 0, 0) * (deltaY * (Float.pi / 180) / sensitivityFactor)
        let rotation = rotationX + rotationY
        
        // Aplica a rotação ao nó da esfera
        let euler = self.planetNode.eulerAngles
        let simdEuler = simd_float3(euler.x, euler.y, euler.z)
        self.planetNode.eulerAngles = SCNVector3(simdEuler + rotation)
        
        // Salva a posição atual do toque como a posição anterior
        self.lastPosition = currentTouchLocation
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Reseta a posição anterior do toque
        self.lastPosition = nil
    }
    
    func materialDefining(planetName: String) -> String {
        switch planetName {
        case "Terra":
            return "Earth"
        case "Marte":
            return "Mars"
        case "Mercúrio":
            return "Mercury"
        case "Vênus":
            return "Venus"
        case "Júpiter":
            return "Jupiter"
        case "Saturno":
            return "Saturn"
        case "Urano":
            return "Uranus"
        case "Netuno":
            return "Neptune"
        default:
            return ""
        }
    }
    
    func setMaterial() -> UIImage? {
        if #available(iOS 16, *) {
            if currentLanguage.language.languageCode?.identifier ?? "" == "pt" {
                return UIImage(named: "\(materialDefining(planetName: planetInfos.name)).jpeg")
            } else {
                return UIImage(named: "\(planetInfos.name).jpeg")
            }
        } else {
            // Fallback on earlier versions
            if currentLanguage.languageCode == "pt" {
                return UIImage(named: "\(materialDefining(planetName: planetInfos.name)).jpeg")
            } else {
                return UIImage(named: "\(planetInfos.name).jpeg")
            }
        }
    }
    
    func createPlanetSphere() {
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        
        material.diffuse.contents = setMaterial()
        sphere.materials = [material]
        
        self.planetNode.position = SCNVector3Make(0, 0, -0.6)
//        self.planetNode.scale = lastScale
        self.planetNode.geometry = sphere
        self.planetNode.name = "planet"
        
        arView.scene.rootNode.addChildNode(self.planetNode)
        arView.automaticallyUpdatesLighting = true
    }
    
}
