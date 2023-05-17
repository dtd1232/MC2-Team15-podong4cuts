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
    @Published var selectedModel = ARModel(name: "", faceUsdz: "", worldUsdz: "", configuration: .FaceTracking, cameraPosition: 1)

//    lazy var worldAnchor = addUSDZToAnchorEntity(usdz: selectedModel.worldUsdz)
//      lazy var faceAnchor = addUSDZToAnchorEntity(usdz: selectedModel.faceUsdz)
    
    func selectModel(number: Int) {
        selectedNumber = number
        selectedModel = models[selectedNumber]
    }
    
    func loadEntity(name: String) -> Entity {
        let entity = try! Entity.load(named: name)
        
        return entity
    }
    
    func addUSDZToAnchorEntity(usdz: String) -> AnchorEntity {
        if usdz == "MoonReality" {
            if let fileURL = Bundle.main.url(forResource: "MoonReality", withExtension: "reality") {
                let scene = try! Entity.load(contentsOf: fileURL)
                let anchorAntity = AnchorEntity(world: [0,0,0])
                anchorAntity.addChild(scene)
                return anchorAntity
            }
        }
        
        if usdz == "WhaleAR" || usdz == "WhaleAR 2" {
            if let fileURL = Bundle.main.url(forResource: "WhaleReality", withExtension: "reality") {
                let scene = try! Entity.load(contentsOf: fileURL)
                let anchorAntity = AnchorEntity(world: [0,0,0])
                anchorAntity.addChild(scene)
                return anchorAntity
            }
        }
        
        let anchorEntity = AnchorEntity(world: [0,0,0])
        anchorEntity.addChild(loadEntity(name: usdz))
        
        return anchorEntity
    }
    
//    func addAR(arView: ARView) {
//        guard selectedModel.configuration == .WorldTracking else { return }
//
//        let anchor = addUSDZToAnchorEntity(usdz: selectedModel.worldUsdz)
//        let cameraTransform: Transform = arView.cameraTransform
//        let localCameraPosition: SIMD3<Float> = anchor.convert(position: cameraTransform.translation, from: nil)
//        let cameraForwardVector: SIMD3<Float> = cameraTransform.matrix.forward
//        let finalPosition: SIMD3<Float> = localCameraPosition + cameraForwardVector * selectedModel.cameraPosition
//
//        anchor.transform.translation = finalPosition
//        arView.scene.anchors.append(anchor)
//    }
    
    func setPointLight() -> PointLight {
        let pointLight = PointLight()
        
        pointLight.light.color = .orange
        pointLight.light.intensity = 15000000
        pointLight.light.attenuationRadius = 7.0
        pointLight.position = [0,0,0]
        
        
        return pointLight
    }
    
    func relocateAR(arView: ARView) {
//        guard !(arView.session.currentFrame?.anchors.first is ARFaceAnchor) else { return }
        guard !(arView.scene.anchors.isEmpty) else { return }
            arView.scene.anchors.removeAll(keepCapacity: true)
        
        DispatchQueue.global(qos: .background).sync {
            if selectedModel.configuration == .WorldTracking {
                let anchor = addUSDZToAnchorEntity(usdz: selectedModel.worldUsdz)
                let cameraTransform: Transform = arView.cameraTransform
                let localCameraPosition: SIMD3<Float> = anchor.convert(position: cameraTransform.translation, from: nil)
                let cameraForwardVector: SIMD3<Float> = cameraTransform.matrix.forward
                let finalPosition: SIMD3<Float> = localCameraPosition + cameraForwardVector * selectedModel.cameraPosition
                
                anchor.transform.translation = finalPosition
                arView.scene.anchors.append(anchor)
            }
            else {
                if !(arView.scene.anchors.isEmpty) {
                    arView.scene.anchors.removeAll(keepCapacity: true)
                }
                let anchor = addUSDZToAnchorEntity(usdz: selectedModel.faceUsdz)
                let cameraTransform: Transform = arView.cameraTransform
                let localCameraPosition: SIMD3<Float> = anchor.convert(position: cameraTransform.translation, from: nil)
                let cameraForwardVector: SIMD3<Float> = cameraTransform.matrix.forward
                let finalPosition: SIMD3<Float> = localCameraPosition + cameraForwardVector * selectedModel.cameraPosition
                
                anchor.transform.translation = finalPosition
                arView.scene.anchors.append(anchor)
            }
        }
    }
    
    func switchCamera() {
        switch selectedModel.configuration {
        case .FaceTracking:
            selectedModel.configuration = .WorldTracking

        case .WorldTracking:
            selectedModel.configuration = .FaceTracking
            
        
        }
    }
}

extension ARView {
    func setConfiguration(configuration: Configuration) {
        switch configuration {
        case .FaceTracking:
            
            let configuration = ARFaceTrackingConfiguration()
            configuration.maximumNumberOfTrackedFaces = 2
            configuration.isWorldTrackingEnabled = true

            self.session.run(configuration)
            
        case .WorldTracking:
            let configuration = ARWorldTrackingConfiguration()
            configuration.frameSemantics = .personSegmentationWithDepth
            configuration.worldAlignment = .gravityAndHeading

            self.session.run(configuration)
        }
    }
}
