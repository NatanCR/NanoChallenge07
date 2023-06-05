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
    @State var planetInfos: PlanetInfos
    //    @State var isActive: Bool
    
    func makeUIViewController(context: Context) -> ARKitView {
        //cria o estado inicial da visualização e retorna
        return ARKitView(planetInfos: planetInfos)
    }
    func updateUIViewController(_ uiViewController:
                                ARViewIndicator.UIViewControllerType, context:
                                //atualiza o estado da visualização
                                UIViewControllerRepresentableContext<ARViewIndicator>) { }
}

class ARKitView: UIViewController, ARSCNViewDelegate { //SCNSceneRendererDelegate
    private var planetInfos: PlanetInfos
    private var planetNode = SCNNode()
    private var lastPosition: CGPoint?
    private var currentLanguage = Locale.current
    private var infosServices = InfosService()
    private var textNode = SCNNode()
    private var isActive: Bool
    
    init(planetInfos: PlanetInfos) {
        self.planetInfos = planetInfos
        self.isActive = false
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
        view = arView
        
        createPlanetSphere()
        updateText()
        if planetInfos.id == 3 {
            createMoonSphere()
            arView.addMaterialChangeButton(target: self, action: #selector(changeMaterial))
        }
    }
    
    @objc func changeMaterial() {
        if !isActive {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "EarthNight.jpeg")
            planetNode.geometry?.materials = [material]
            self.isActive.toggle()
        } else if isActive {
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "Earth.jpeg")
            planetNode.geometry?.materials = [material]
            self.isActive.toggle()
        }
        arView.updateMaterialChangeButtonIcon(isActive: isActive)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Obtém a localização do toque atual
        guard let currentTouchLocation = touches.first?.location(in: arView) else { return }
        
        // Salva a posição do toque atual
        lastPosition = currentTouchLocation
        textNode.removeFromParentNode()
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
        case "Sol":
            return "Sun"
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
        
        self.planetNode.position = SCNVector3Make(0, 0, -0.7)
        self.planetNode.geometry = sphere
        self.planetNode.name = "planet"
        
        arView.scene.rootNode.addChildNode(self.planetNode)
        arView.automaticallyUpdatesLighting = true
    }
    
    func createMoonSphere() {
        let moonGeometry = SCNSphere(radius: 0.05)
        let moonMaterial = SCNMaterial()
        
        moonMaterial.diffuse.contents = UIImage(named: "Moon.jpeg")
        moonGeometry.materials = [moonMaterial]
        
        let moonNode = SCNNode(geometry: moonGeometry)
        moonNode.position = SCNVector3(x: 0.4, y: 0, z: 0)
        planetNode.addChildNode(moonNode)
        
        let moonOrbitAction = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: 10))
        moonNode.runAction(moonOrbitAction)
    }
    
    func updateText() {
        let textGeometry = SCNText(string: NSLocalizedString("drag", comment: ""), extrusionDepth: 1.0)
        textGeometry.firstMaterial?.diffuse.contents = InfosService.chooseShadowColor(id: planetInfos.id)
        
        textNode = SCNNode(geometry: textGeometry)
        textNode.position = SCNVector3(x: -0.1, y: -0.3, z: -0.4)
        textNode.scale = SCNVector3(x: 0.004, y: 0.004, z: 0.004)
        arView.scene.rootNode.addChildNode(textNode)
    }
    
}

extension ARSCNView {
    var materialChangeButton: UIButton? {
        return viewWithTag(100) as? UIButton
    }
    
    func addMaterialChangeButton(target: Any?, action: Selector) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "moon.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = UIColor.white
        button.tag = 100
        
        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    func updateMaterialChangeButtonIcon(isActive: Bool) {
        if let button = materialChangeButton {
            if isActive {
                button.setImage(UIImage(systemName: "sun.max.fill"), for: .normal)
                button.tintColor = UIColor.yellow
            } else {
                button.setImage(UIImage(systemName: "moon.fill"), for: .normal)
                button.tintColor = UIColor.white
            }
        }
    }
}
