//
//  SpaceWalkSpaceARView.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/10.
//

import ARKit
import RealityKit
import SwiftUI

struct SpaceWalkSpaceARView: UIViewRepresentable {
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
    let sauryHead = try! Entity.load(named: "sauryHead")
    let sauryHead2 = try! Entity.load(named: "sauryHead")
    let sauryHead3 = try! Entity.load(named: "sauryHead")
    
    func makeUIView(context: Context) -> ARView {
        let faceTrackingConfiguration = ARFaceTrackingConfiguration()
        faceTrackingConfiguration.maximumNumberOfTrackedFaces = 3
        
        arView.session.run(faceTrackingConfiguration)
        arView.session.delegate = context.coordinator
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(target: self)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var target: SpaceWalkSpaceARView
        
        init(target: SpaceWalkSpaceARView) {
            self.target = target
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            
            guard let faceAnchor = anchors.first as? ARFaceAnchor
            else { return }
            let anchor1 = AnchorEntity(.face)
            var anchor2 = AnchorEntity(.face)
            var anchor3 = AnchorEntity(.face)
            
            if anchors.count == 3 {
                anchor2 = AnchorEntity(.face)
                anchor3 = AnchorEntity(.face)
                
                
                anchor2.addChild(target.sauryHead2)
                anchor3.addChild(target.sauryHead3)
                
            } else if anchors.count == 2 {
                anchor2 = AnchorEntity(.face)
                
                anchor2.addChild(target.sauryHead2)
                
            }
            
            anchor1.addChild(target.sauryHead)

            target.arView.scene.anchors.append(anchor1)
            target.arView.scene.anchors.append(anchor2)
            target.arView.scene.anchors.append(anchor3)
        }
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
}
