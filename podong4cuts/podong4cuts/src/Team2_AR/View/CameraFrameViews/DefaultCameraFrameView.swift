//
//  DefaultCameraFrameView.swift
//  podong4cuts
//
//  Created by user on 2023/05/14.
//

import SwiftUI

struct DefaultCameraFrameView: View {
    let selected: Int
    @ViewBuilder var body: some View {
        switch (selected) {
        case 0:
            SpaceWalkSpaceCameraFrameView()
        case 1:
            TomatiloMustacheCameraFrameView()
        case 2:
            YeongilgyoKrabFilterView()
        case 3:
            WhaleTailCameraFrameView()
        default:
            WhaleTailCameraFrameView()
        }
    }
}

struct DefaultCameraFrameView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultCameraFrameView(selected: 3)
    }
}
