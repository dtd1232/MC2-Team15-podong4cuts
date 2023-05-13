//
//  Tomatillo.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/11.
//

import SwiftUI
import ARKit
import RealityKit

struct TomatilloMustacheARView: UIViewRepresentable {
    
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    
    func makeUIView(context: Context) -> ARView {
        let scene = try! Entity.loadModel(named: "Mask", in: nil)
        let anchor = AnchorEntity(world: [0,0,0])
        
        let perspectiveCamera = PerspectiveCamera()
//        let cameraAnchor = AnchorEntity(world: [0,0,0.8])
//        perspectiveCamera.look(at: [0,0,0], from: [0,0,0.8], relativeTo: nil)
        
        scene.generateCollisionShapes(recursive: true)
        
        anchor.addChild(scene)
//        cameraAnchor.addChild(perspectiveCamera)
        arView.installGestures([.scale, .translation], for: scene)
        arView.scene.anchors.append(anchor)
//        arView.scene.anchors.append(cameraAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}


