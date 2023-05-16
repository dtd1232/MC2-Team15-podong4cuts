//
//  ViewController.swift
//  ARCL3
//
//  Created by Song Jihyuk on 2023/05/08.
//


import ARKit
import RealityKit
import SwiftUI

struct WhaleTailWhaleARView: UIViewRepresentable {
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
    
    func makeUIView(context: Context) -> some UIView {
        let locationManager = CLLocationManager()
        locationManager.startUpdatingLocation()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .personSegmentationWithDepth
        configuration.worldAlignment = .gravityAndHeading
    

        let usdzURL = Bundle.main.url(forResource: "WhaleAR", withExtension: "usdz")
        let scene = try! SCNScene(url: usdzURL!, options: [.checkConsistency: true])
        
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
