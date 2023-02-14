//
//  ARKitView.swift
//  API_Nasa
//
//  Created by Natan de Camargo Rodrigues on 14/02/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.delegate = self
        
        createPlanetSphere()
    }
    
    func createPlanetSphere() {
        let sphere = SCNSphere(radius: 0.2)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "nome do arquivo")
        sphere.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(0, 0.1, -0.5)
        node.geometry = sphere
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.automaticallyUpdatesLighting = true
    }
}
