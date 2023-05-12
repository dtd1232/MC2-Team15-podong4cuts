//
//  SpotModel.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import SwiftUI
import CoreLocation

enum Spot {
    case WhaleTail
    case SpaceWork
    case GlobalMyth
    case OhBremen
    case Tomatillo
    case YoungilBridge
}

struct SpotModel {
    let SpotName: Spot
    let coorinate: CLLocationCoordinate2D
}
