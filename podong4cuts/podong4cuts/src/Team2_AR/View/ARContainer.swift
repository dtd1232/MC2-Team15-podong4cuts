//
//  ARViewContainer.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/15.
//

import SwiftUI
import RealityKit
import ARKit
import PhotosUI



struct ARContainerView: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    // cameraview ui
    @State private var shutterEffect = false
    
    // tempsnapshotview
    @State var thumbnail: UIImage?
    @State var tempSnapShot: UIImage?
    @State var showTempSnapShotView = false
    
    // photolibraryview
    @State var showPhotoLibrary = false
    var arViewContainer = ARContainer()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                VStack(spacing: 0) {
                    // upper bar
                    HStack {
                        Button {
                            withAnimation(.easeInOut) {
                                cameraViewModel.showDefaultCameraFrameView = false
                            }
                            
                        } label: {
                            
                            Image(systemName: "chevron.left")
                                .resizable()
                                .foregroundColor(.blue)
                                .scaledToFit()
                                .frame(width: 12)
                                .padding()
                        }
                        
                        Spacer()
                            .padding()
                    }
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    
                    
                    // middle arview
                    GeometryReader { proxy in
                        arViewContainer
                            .brightness(shutterEffect ? -1 : 0)
                    }
                    
                    // bottom button bar
                    
                    // thumbnail button
                    HStack {
                        if thumbnail != nil {
                            Button {
                                showPhotoLibrary = true
                            } label: {
                                Image(uiImage: thumbnail!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .frame(width: 65, height: 65)
                        } else {
                            Button {
                                showPhotoLibrary = true
                            } label: {
                                Image("ExampleCat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        
                        
                        Spacer()
                        
                        
                        // take photo button
                        Button {
                            //                            if soundOn {
                            //                                SoundPlayer.soundPlayer.play(fileName: "ShutterSound")
                            //                            }
                            
                            // haptic
                            let haptic = UIImpactFeedbackGenerator(style: .rigid)
                            haptic.impactOccurred()
                            
                            // shutter effect
                            withAnimation(.easeInOut(duration: 0.1)) {
                                shutterEffect = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.easeInOut(duration: 0.1)) {
                                    self.shutterEffect = false
                                }
                                
                                // snapshot
                                arViewContainer.arView.snapshot(saveToHDR: false) { image in
                                    tempSnapShot = image
                                }
//                                tempSnapShot = arViewContainer.sceneLocationView.snapshot()
                                showTempSnapShotView = true
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .frame(width: 65, height: 65)
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .frame(width: 75, height: 75)
                            }
                        }
                        
                        Spacer()
                        
                        // fake button for center alignment
                        Button("") {
                            
                        }
                        .frame(width: 65, height: 65)
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .onAppear {
                    }
                    
                }
                
                NavigationLink("", isActive: $showTempSnapShotView) {
                    TempSnapShotView(thumbnail: $thumbnail, tempSnapShot: tempSnapShot)
                }
                
                NavigationLink("", isActive: $showPhotoLibrary) {
                    PhotoLibraryView()
                }
            }
        }
        .onAppear {
            setPhotoLibraryImage { image in
                thumbnail = image
            }
        }
    }
    
    func setPhotoLibraryImage(completion: @escaping (UIImage?) -> Void) {
        let fetchOption = PHFetchOptions()
        fetchOption.fetchLimit = 1
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchPhotos = PHAsset.fetchAssets(with: fetchOption)
        if let photo = fetchPhotos.firstObject {
            ImageManager.shared.requestImage(from: photo, thumbnailSize: CGSize(width: 40, height: 40)) { image in
                completion(image)
            }
        }
    }
}


//struct ARContainerView: View {
//    @EnvironmentObject var cameraViewModel: CameraViewModel
//
//    var body: some View {
//        ARContainer()
//            .onTapGesture {
//                cameraViewModel.showDefaultCameraFrameView = false
//            }
//    }
//}

struct ARContainer: UIViewRepresentable {
    @EnvironmentObject var arViewModel: ARViewModel
    var arView: ARView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)

    func makeUIView(context: Context) -> ARView {
        
        arView.setConfiguration(configuration: arViewModel.selectedModel.configuration)
        
        if arViewModel.selectedModel.configuration == .FaceTracking {
            arView.session.delegate = context.coordinator
         }
        
        if arViewModel.selectedModel.configuration == .WorldTracking {
            arView.environment.lighting.intensityExponent = 2
            let anchor = arViewModel.addUSDZToAnchorEntity(usdz: arViewModel.selectedModel.usdz)
            let perspectiveCamera = PerspectiveCamera()
            let cameraAnchor = AnchorEntity(world: [0,0,0])
            perspectiveCamera.look(at: [0,0,0], from: arViewModel.selectedModel.cameraPosition, relativeTo: nil)
            cameraAnchor.addChild(perspectiveCamera)
            arView.scene.anchors.append(cameraAnchor)
            arView.scene.anchors.append(anchor)
        }
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(target: self)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
//        let anchorEntity = arViewModel.addUSDZToAnchorEntity(usdz: arViewModel.selectedModel.usdz)
        
        
//        uiView.scene.anchors.append(anchorEntity)
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var target: ARContainer
        var usdz: Entity
        
        init(target: ARContainer) {
            self.target = target
            self.usdz = target.arViewModel.loadEntity(name: target.arViewModel.selectedModel.usdz)
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            
            guard let faceAnchor = anchors.first as? ARFaceAnchor
            else { return }
            
            let anchor1 = AnchorEntity(.face)
            var anchor2 = AnchorEntity(.face)

            if anchors.count == 2 {
                anchor2 = AnchorEntity(anchor: anchors[1])
                
                anchor2.addChild(usdz)
            }
            
            anchor1.addChild(usdz)

            target.arView.scene.anchors.append(anchor1)
            target.arView.scene.anchors.append(anchor2)
        }
    }
}
