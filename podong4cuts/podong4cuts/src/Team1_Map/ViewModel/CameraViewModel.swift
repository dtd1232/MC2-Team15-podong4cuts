//
//  CameraViewModel.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/15.
//

import SwiftUI

class CameraViewModel: ObservableObject {
    @Published var selectedNumber: Int = 0
//    @Published var
    @Published var showDefaultCameraFrameView: Bool = false
}
