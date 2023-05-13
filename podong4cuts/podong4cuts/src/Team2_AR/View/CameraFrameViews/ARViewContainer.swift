//
//  ARViewContainer.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit
import CoreImage

struct ARViewContainer: UIViewRepresentable {
    var arView: ARView = ARView(frame: .zero)
    var snapShot: UIImage?
//    var arView: ARView
//    @Binding var showFullScreenSheet: Bool
//    @Binding var tempSnapShot: UIImage?
//
//    init(position: CGPoint ,width: CGFloat, height: CGFloat, showFullScreenSheet: Binding<Bool>, tempSnapShot: Binding<UIImage?>) {
//        arView = ARView(frame: CGRect(x: position.x, y: position.y, width: width, height: height))
//        _showFullScreenSheet = showFullScreenSheet
//        _tempSnapShot = tempSnapShot
//    }
    
    func makeUIView(context: Context) -> ARView {
        
//        arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
        return arView
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
    }
    
//    func saveSnapShot(snapShot: UIImage) {
//        UIImageWriteToSavedPhotosAlbum(snapShot, nil, nil, nil)
//    }
//
    
    func cropImage(position: CGPoint, width: CGFloat, height: CGFloat, inputImage: UIImage)-> UIImage? {
        let cropZone = CGRect(x: position.x, y: position.y, width: width, height: height)
        
        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to: cropZone) else { return nil}
        return UIImage(cgImage: cutImageRef)
//        return UIImage(cgImage: cutImageRef, scale: inputImage.imageRendererFormat.scale, orientation: inputImage.imageOrientation)
    }
    
//    func reRun() {
//        let config = ARWorldTrackingConfiguration()
//        arView.session.run(config)
//    }
    
}
