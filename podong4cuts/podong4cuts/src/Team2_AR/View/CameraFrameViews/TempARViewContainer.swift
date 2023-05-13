//
//  TempARViewContainer.swift
//  podong4cuts
//
//  Created by user on 2023/05/10.
//

import Foundation

import Foundation
import SwiftUI
import RealityKit
import ARKit
import CoreImage

struct TempARViewContainer: UIViewRepresentable {
    var arView: ARView
    
    init() {
        arView = ARView(frame: .zero)
        
    }
    
    func makeUIView(context: Context) -> ARView {
        
//        arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        let configuration = ARWorldTrackingConfiguration()
        arView.session.run(configuration)
        
        return arView
    }
    
    func updateUIView(_ arView: ARView, context: Context) {}
    
}

