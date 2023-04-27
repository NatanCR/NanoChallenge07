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
    //Store The Rotation Of The CurrentNode
//    var currentAngleY: Float = 0.0
//    var isRotating = false
    let node = SCNNode()
    
    init(planetInfos: PlanetInfos) {
        self.planetInfos = planetInfos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented") //tratamento de erro
    }
    
    var arView: ARSCNView {
        return self.view as! ARSCNView
    }
    override func loadView() {
        self.view = ARSCNView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.delegate = self
        arView.scene = SCNScene()
        createPlanetSphere()
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveNode(_:)))
//        self.view.addGestureRecognizer(panGesture)
//
//        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotateNode(_:)))
//        self.view.addGestureRecognizer(rotateGesture)
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
    
//    /// - Parameter gesture: UIRotationGestureRecognizer
//    @objc func rotateNode(_ gesture: UIRotationGestureRecognizer){
//
//        //1. Get The Current Rotation From The Gesture
//        let rotation = Float(gesture.rotation)
//
//        //2. If The Gesture State Has Changed Set The Nodes EulerAngles.y
//        if gesture.state == .changed{
//            isRotating = true
//            self.node.eulerAngles.y = currentAngleY + rotation
//        }
//
//        //3. If The Gesture Has Ended Store The Last Angle Of The Cube
//        if(gesture.state == .ended) {
//            currentAngleY = self.node.eulerAngles.y
//            isRotating = false
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.arView {
            guard let viewTouchLocation:CGPoint = touch?.location(in: arView) else { return }
          
          guard let result = arView.hitTest(viewTouchLocation, options: nil).first else {
            return
          }
          if result.node.name == "planet" {
            print("TOQUEI NO PLANETA")
          }
        }
    }
    
    func createPlanetSphere() { // cria a esfera do planeta
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(planetInfos.name).jpeg")
        sphere.materials = [material]
        
        self.node.position = SCNVector3Make(0, 0.1, -0.8)
        self.node.geometry = sphere
        self.node.name = "planet"
        
        arView.scene.rootNode.addChildNode(self.node)
//        addAnimation(node: self.node)
        arView.automaticallyUpdatesLighting = true
    }
    
    func addAnimation(node: SCNNode) { //faz a rotação do node
        let rotateOne = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 5.0)
        let repeatForever = SCNAction.repeatForever(rotateOne)
        node.runAction(repeatForever)
    }
    
}
