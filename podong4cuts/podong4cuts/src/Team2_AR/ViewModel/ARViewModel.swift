//
//  ARViewModel.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/15.
//

import SwiftUI
import ARKit
import RealityKit



class ARViewModel: ObservableObject {
    let models = arModels
    @Published var selectedNumber: Int = 0
    @Published var selectedModel = ARModel(name: "", usdz: "", configuration: .FaceTracking, cameraPosition: [0,0,0])
    
    func selectModel(number: Int) {
        selectedNumber = number
        selectedModel = models[selectedNumber]
    }
    
    func loadEntity(name: String) -> Entity {
        let entity = try! Entity.load(named: name)
        
        return entity
    }
    
    func addUSDZToAnchorEntity(usdz: String) -> AnchorEntity {
        let anchorEntity = AnchorEntity(world: [0,0,0])
        anchorEntity.addChild(loadEntity(name: usdz))
        
        return anchorEntity
    }
}

extension ARView {
    func setConfiguration(configuration: Configuration) {
        switch configuration {
        case .FaceTracking:
            let configuration = ARFaceTrackingConfiguration()
            configuration.maximumNumberOfTrackedFaces = 3
            
            self.session.run(configuration)
            
        case .WorldTracking:
            let configuration = ARWorldTrackingConfiguration()
            configuration.frameSemantics = .personSegmentationWithDepth
            configuration.worldAlignment = .gravityAndHeading
            
            self.session.run(configuration)
        }
    }
}
