//
//  WhaleTailCameraFrame.swift
//  podong4cuts
//
//  Created by user on 2023/05/14.
//

import SwiftUI
import PhotosUI
import RealityKit
import ARKit

struct TomatiloMustacheCameraFrameView: View {
    // cameraview ui
    @State private var shutterEffect = false
    
    // tempsnapshotview
    @State var thumbnail: UIImage?
    @State var tempSnapShot: UIImage?
    @State var showTempSnapShotView = false
    
    // photolibraryview
    @State var showPhotoLibrary = false
    
    var arViewContainer = TomatilloMustacheARView()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    
                    // upper bar
                    HStack {
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
//                                tempSnapShot = arViewContainer.arView.snapshot()
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


struct TomatiloMustacheCameraFrameViewPreview: PreviewProvider {
    static var previews: some View {
        CameraFrameView()
    }
}



