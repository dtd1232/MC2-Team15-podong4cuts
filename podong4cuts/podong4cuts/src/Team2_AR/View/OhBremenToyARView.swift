//
//  SpaceWalkSpaceARView.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/10.
//

import ARKit
import RealityKit
import SwiftUI

struct OhBremenToyARView: UIViewRepresentable {
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    func makeUIView(context: Context) -> ARView {
        let anchor = AnchorEntity(.image(group: "AR Resources", name: "horse"))
        let scene = try! OB.load장면()

        anchor.addChild(scene)
        arView.scene.anchors.append(anchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        
        
    }
}
