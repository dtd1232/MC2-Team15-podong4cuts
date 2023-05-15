//
//  YeongilgyoKrabFilterView.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/13.
//
import ARKit
import RealityKit
import SwiftUI

struct YeongilgyoKrabFilterView: UIViewRepresentable {
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    func makeUIView(context: Context) -> some UIView {
        let scene = try! Entity.load(named: "Krab")
        let krabAnchor = AnchorEntity(world: [0,0,0])
    
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0,0,0])
        camera.look(at: [0,0,0], from: [0,0,70], relativeTo: nil)
        
        cameraAnchor.addChild(camera)
        krabAnchor.addChild(scene)
        
        arView.scene.anchors.append(cameraAnchor)
        arView.scene.anchors.append(krabAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
