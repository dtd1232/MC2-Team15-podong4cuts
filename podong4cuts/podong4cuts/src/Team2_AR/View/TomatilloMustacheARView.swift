//
//  Tomatillo.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/11.
//

import SwiftUI
import ARKit
import RealityKit

struct ABCDEFU: View {
    @State private var clicked = false
    
    var body: some View {
        ZStack {
            TomatilloMustacheARView(clicked: $clicked)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Circle()
                        .foregroundColor(.white)
                        .overlay {
                            Image(systemName: "plus.diamond.fill")
                                .foregroundColor(.black)
                        }
                        .frame(width: 60, height: 60)
                        .padding()
                        .onTapGesture {
                            clicked.toggle()
                        }
                    
                    Spacer()
                }
            }
        }
    }
}


struct TomatilloMustacheARView: UIViewRepresentable {
    @Binding var clicked: Bool
    let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: true)
    
    
    func makeUIView(context: Context) -> ARView {
        let scene = try! Entity.loadModel(named: "Mask", in: nil)
        let anchor = AnchorEntity(world: [0,0,0])
        
        let perspectiveCamera = PerspectiveCamera()
//        let cameraAnchor = AnchorEntity(world: [0,0,0.8])
//        perspectiveCamera.look(at: [0,0,0], from: [0,0,0.8], relativeTo: nil)
        
        scene.generateCollisionShapes(recursive: true)
        
        anchor.addChild(scene)
//        cameraAnchor.addChild(perspectiveCamera)
        arView.installGestures([.scale, .translation], for: scene)
        arView.scene.anchors.append(anchor)
//        arView.scene.anchors.append(cameraAnchor)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if clicked {
            let scene = try! Entity.loadModel(named: "Mask", in: nil)
            scene.generateCollisionShapes(recursive: true)
            let anchor = AnchorEntity(world: [0,0,0.8])
            anchor.addChild(scene)
            uiView.installGestures([.scale, .translation], for: scene)
            uiView.scene.anchors.append(anchor)
        }
    }
}


