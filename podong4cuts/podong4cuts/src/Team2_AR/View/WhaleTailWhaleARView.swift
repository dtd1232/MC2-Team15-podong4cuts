//
//  ViewController.swift
//  ARCL3
//
//  Created by Song Jihyuk on 2023/05/08.
//

import ARKit_CoreLocation
import ARKit
import CoreLocation
import SwiftUI

struct WhaleTailWhaleARView: UIViewRepresentable {
    let sceneLocationView = SceneLocationView()
    
    func makeUIView(context: Context) -> some UIView {
        let locationManager = CLLocationManager()
        locationManager.startUpdatingLocation()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .personSegmentationWithDepth
        configuration.worldAlignment = .gravityAndHeading
        sceneLocationView.session.run(configuration)
        sceneLocationView.autoenablesDefaultLighting = true
        
        let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 36.05282, longitude: 129.37828), altitude: 30000)
        let locationNode = LocationNode(location: location)

        let usdzURL = Bundle.main.url(forResource: "WhaleAR", withExtension: "usdz")
        let scene = try! SCNScene(url: usdzURL!, options: [.checkConsistency: true])
        
        let node = scene.rootNode.childNodes[0]
        
        locationNode.addChildNode(node)
        locationNode.continuallyUpdatePositionAndScale = false
        locationNode.continuallyAdjustNodePositionWhenWithinRange = false
        locationNode.scaleRelativeToDistance = true
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: locationNode)
        
        return sceneLocationView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
