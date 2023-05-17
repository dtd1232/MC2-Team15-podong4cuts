//
//  SpotModel.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import SwiftUI

struct ARModel {
    let name: String
    let faceUsdz: String
    let worldUsdz: String
    var configuration: Configuration
    let cameraPosition: Float
}


enum Configuration {
    case FaceTracking
    case WorldTracking
}


let arModels: [ARModel] = [ARModel(name: "SpaceWalk", faceUsdz: "sauryHead", worldUsdz: "MoonReality", configuration: .FaceTracking, cameraPosition: 1),
                           ARModel(name: "Tomatillo", faceUsdz: "Mask", worldUsdz: "Mask_WorldConfiguration", configuration: .FaceTracking, cameraPosition: 1),
                           ARModel(name: "Yeongilgyo", faceUsdz: "Krab", worldUsdz: "Krab", configuration: .WorldTracking, cameraPosition: 100),
                           ARModel(name: "WhaleTail", faceUsdz: "WhaleAR 2", worldUsdz: "WhaleAR", configuration: .WorldTracking, cameraPosition: 10)
                           ]
        
