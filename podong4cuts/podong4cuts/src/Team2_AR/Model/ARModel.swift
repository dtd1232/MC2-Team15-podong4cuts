//
//  SpotModel.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import SwiftUI

struct ARModel {
    let name: String
    let usdz: String
    let configuration: Configuration
    let cameraPosition: SIMD3<Float>
}


enum Configuration {
    case FaceTracking
    case WorldTracking
}


let arModels: [ARModel] = [ARModel(name: "SpaceWalk", usdz: "sauryHead", configuration: .FaceTracking, cameraPosition: [0,0,0]),
                           ARModel(name: "Tomatillo", usdz: "Mask", configuration: .FaceTracking, cameraPosition: [0,0,0]),
                           ARModel(name: "Yeongilgyo", usdz: "Krab", configuration: .WorldTracking, cameraPosition: [0,0,-30]),
                           ARModel(name: "WhaleTail", usdz: "WhaleAR", configuration: .WorldTracking, cameraPosition: [0,-1,-6])
                           ]
        