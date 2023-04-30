//
//  ARKitView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 14/02/23.
//

import Foundation
import ARKit
import SwiftUI
import RealityKit

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

class ARKitView: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    var planetInfos: PlanetInfos
    var planetNode = SCNNode()
    var sphereAnchor = AnchorEntity()
    
    init(planetInfos: PlanetInfos) {
        self.planetInfos = planetInfos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //tratamento de erro
    }
    
    var arView: ARView {
        return self.view as! ARView
    }
    override func loadView() {
        self.view = ARView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        arView.delegate = self
//        arView.scene = SCNScene()
//        createPlanetSphere()
        arView.session.delegate = self
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                arView.addGestureRecognizer(panGesture)
        
        let planet = createNode()
        placeNode(sphere: planet ?? ModelEntity(), at: SIMD3(x: 0, y: 0, z: -0.8))
        installGesture(on: planet ?? ModelEntity())
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
//        arView.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        arView.session.pause()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first
//        if touch?.view == self.arView {
//            guard let viewTouchLocation: CGPoint = touch?.location(in: arView) else { return }
//
//          guard let result = arView.hitTest(viewTouchLocation, options: nil).first else {
//            return
//          }
//          let worldTouchPosition = arView.unprojectPoint(SCNVector3(viewTouchLocation.x, viewTouchLocation.y, 0))
//          if result.node.name == "planet" {
//
//            print("TOQUEI NO PLANETA")
//          }
//        }
//    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            // Get the translation of the gesture
            let translation = gesture.translation(in: arView)
            
            // Move the box anchor vertically
            let verticalDistance = Float(translation.y / 100) // adjust the divisor to change the sensitivity of the movement
            sphereAnchor.position.y += verticalDistance
            
            // Reset the gesture's translation
            gesture.setTranslation(.zero, in: arView)
        }
    
    func createNode() -> ModelEntity? {
        let sphere = MeshResource.generateSphere(radius: 0.2)
        // Load the texture resource
           guard let texture = try? TextureResource.load(named: "\(planetInfos.name)") else {
               return nil
           }
           
           // Create a material and set its texture property
        var material = SimpleMaterial()
           material.color.texture = .init(texture)
        
        let sphereEntity = ModelEntity(mesh: sphere, materials: [material])
        
        return sphereEntity
    }
    
    func placeNode(sphere: ModelEntity, at position: SIMD3<Float>) {
        self.sphereAnchor = AnchorEntity(world: position)
        self.sphereAnchor.position = [0,0,-1]
        self.sphereAnchor.addChild(sphere)
        self.arView.scene.addAnchor(sphereAnchor)
    }
    
    func installGesture(on object: ModelEntity) {
        object.generateCollisionShapes(recursive: true)
        arView.installGestures([.rotation,.scale],for: object)
    }
    
//    func createPlanetSphere() { // cria a esfera do planeta
//        let sphere = SCNSphere(radius: 0.2)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "\(planetInfos.name).jpeg")
//        sphere.materials = [material]
//
//        self.planetNode.position = SCNVector3Make(0, 0.1, -0.8)
//        self.planetNode.geometry = sphere
//        self.planetNode.name = "planet"
//
//        arView.scene.rootNode.addChildNode(self.planetNode)
////        addAnimation(node: self.node)
//        arView.automaticallyUpdatesLighting = true
//    }
    
    func addAnimation(node: SCNNode) { //faz a rotação do node
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
    
}
