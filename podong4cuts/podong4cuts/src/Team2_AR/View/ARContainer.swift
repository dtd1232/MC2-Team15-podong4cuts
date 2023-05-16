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
                        
                        // relocate AR butotn
                        Button {
                            
                        } label: {
                            Label("AR 재배치하기", systemImage: "arrow.clockwise")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.white.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
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
                            .foregroundColor(.white)
                            
                        } else {
                            Button {
                                showPhotoLibrary = true
                            } label: {
                                Image(systemName: "photo.stack")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .foregroundColor(.white)
                        }
                        
                        
                        Spacer()
                        
                        
                        // take photo button
                        Button {
                            
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
                                    .fill(.white)
                                    .frame(width: 65, height: 65)

                                Circle()
                                    .stroke(lineWidth: 5)
                                    .fill(.white)
                                    .frame(width: 75, height: 75)
                            }
                        }
                        
                        
                        Spacer()
                        
                        
                        // camera orientation switch button
                        Button {
                            // code to come
                            
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
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
        .onTapGesture {
            cameraViewModel.isClicked.toggle()
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

struct ARContainer: UIViewRepresentable {
    @EnvironmentObject var arViewModel: ARViewModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    var arView: ARView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)

    func makeUIView(context: Context) -> ARView {
        
        arView.setConfiguration(configuration: arViewModel.selectedModel.configuration)
        
        if arViewModel.selectedModel.configuration == .FaceTracking {
            arView.session.delegate = context.coordinator
         }
        
        if arViewModel.selectedModel.configuration == .WorldTracking {
            arView.environment.lighting.intensityExponent = 2
            let anchor = arViewModel.addUSDZToAnchorEntity(usdz: arViewModel.selectedModel.usdz)
//            let perspectiveCamera = PerspectiveCamera()
//            let cameraAnchor = AnchorEntity(world: [0,0,0])
//            perspectiveCamera.look(at: [0,0,0], from: arViewModel.selectedModel.cameraPosition, relativeTo: nil)
//            cameraAnchor.addChild(perspectiveCamera)
//            arView.scene.anchors.append(cameraAnchor)
            arView.scene.anchors.append(anchor)
        }
        
        return arView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(target: self)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if cameraViewModel.isClicked {
            uiView.scene.anchors.removeAll()
            
            if arViewModel.selectedModel.configuration == .FaceTracking {
                uiView.session.delegate = context.coordinator
             }
            
            if arViewModel.selectedModel.configuration == .WorldTracking {
                uiView.environment.lighting.intensityExponent = 2
                let anchor = arViewModel.addUSDZToAnchorEntity(usdz: arViewModel.selectedModel.usdz)
    //            let perspectiveCamera = PerspectiveCamera()
    //            let cameraAnchor = AnchorEntity(world: [0,0,0])
    //            perspectiveCamera.look(at: [0,0,0], from: arViewModel.selectedModel.cameraPosition, relativeTo: nil)
    //            cameraAnchor.addChild(perspectiveCamera)
    //            arView.scene.anchors.append(cameraAnchor)
                uiView.scene.anchors.append(anchor)
            }
        }
        
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var target: ARContainer
        var usdz: Entity
        var usdz2: Entity
        
        init(target: ARContainer) {
            self.target = target
            self.usdz = target.arViewModel.loadEntity(name: target.arViewModel.selectedModel.usdz)
            self.usdz2 = target.arViewModel.loadEntity(name: target.arViewModel.selectedModel.usdz)
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            guard let faceAnchor = anchors.first as? ARFaceAnchor
            else { return }
            
            let anchor1 = AnchorEntity(anchor: faceAnchor)
            var anchor2 = AnchorEntity(anchor: faceAnchor)

            if anchors.count == 2 {
                anchor2 = AnchorEntity(anchor: anchors[1])
                
                anchor2.addChild(usdz2)
            }
            
            anchor1.addChild(usdz)

            target.arView.scene.anchors.append(anchor1)
            target.arView.scene.anchors.append(anchor2)
        }
    }
}
