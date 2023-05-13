//
//  YeongilgyoKrabFilterView.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/13.
//
import ARKit_CoreLocation
import ARKit
import CoreLocation
import SwiftUI

struct YeongilgyoKrabFilterView: UIViewRepresentable {
    let sceneLocationView = SceneLocationView()
    
    func makeUIView(context: Context) -> some UIView {
        
        let locationManager = CLLocationManager()
        locationManager.startUpdatingLocation()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .personSegmentationWithDepth
        configuration.worldAlignment = .gravityAndHeading
        sceneLocationView.session.run(configuration)
        sceneLocationView.autoenablesDefaultLighting = true

        // MARK: 임시 고래꼬리 좌표
//        let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude), altitude: locationManager.location!.altitude)
        

        let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 36.05282, longitude: 129.37828), altitude: 30000)
        let locationNode = LocationNode(location: location)

        
//        let usdzURL = Bundle.main.url(forResource: "WhaleAR", withExtension: "usdz")
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
