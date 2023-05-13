//
//  WhaleTailWhaleARView.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import ARKit_CoreLocation
import ARKit
import CoreLocation
import SwiftUI

struct WhaleTailWhaleARView: UIViewRepresentable {
    let whaleTail = SpotModel(SpotName: .WhaleTail, coorinate: CLLocationCoordinate2D(latitude: 36.053781, longitude: 129.378266))
    
    let arView = SceneLocationView()
    
    func makeUIView(context: Context) -> some UIView {
        
        let locationManager = CLLocationManager()
        
        locationManager.startUpdatingLocation()
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = .personSegmentationWithDepth
        configuration.planeDetection = .horizontal
        configuration.worldAlignment = .gravityAndHeading
        
        arView.session.run(configuration)
        
        arView.autoenablesDefaultLighting = true
        arView.showsStatistics = true

        // MARK: 임시 고래꼬리 좌표
        let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude), altitude: locationManager.location!.altitude)

//        let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: 36.053781, longitude: 129.378266), altitude: locationManager.location!.altitude)
        let locationNode = LocationNode(location: location)
        
        let usdzURL = Bundle.main.url(forResource: "WhaleAR", withExtension: "usdz")
        let scene = try! SCNScene(url: usdzURL!, options: [.checkConsistency: true])
        
        let node = scene.rootNode.childNodes[0]
        
        locationNode.addChildNode(node)
        locationNode.continuallyUpdatePositionAndScale = true
        locationNode.continuallyAdjustNodePositionWhenWithinRange = true
        locationNode.scaleRelativeToDistance = true
        
        arView.addLocationNodeWithConfirmedLocation(locationNode: locationNode)
        arView.isPlaying = true
        
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
