//
//  CameraFrameView.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import SwiftUI
import RealityKit
import ARKit
//import Photos
import PhotosUI

struct CameraFrameView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var geoWidth = 0.0
    @State private var geoHeight = 0.0
    @State private var geoPosition = CGPoint()
    @State private var soundOn = true
    @State private var shutterEffect = false
    
    @State var loadedItem: PHFetchResult<PHAsset> = PHFetchResult()
    @State var showSnapShotSheet = false
    @State var showPhotoLibrary = false
    @State var tempSnapShot: UIImage? = nil
    @State var thumbnail: UIImage? = nil
    
    var arViewContainer = WhaleTailWhaleARView()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button {
                        soundOn.toggle()
                    } label: {
                        if soundOn {
                            Image(systemName: "speaker.wave.2.fill")
                        } else {
                            Image(systemName: "speaker.slash.fill")
                        }
                    }
                    .padding()
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity)
                .background(.black)
                
                GeometryReader { proxy in
                    arViewContainer
                        .onAppear {
                            geoWidth = proxy.size.width
                            geoHeight = proxy.size.height
                            geoPosition = proxy.frame(in: .global).origin
                        }
                        .brightness(shutterEffect ? -1 : 0)
                }
                
                HStack {
                        if thumbnail != nil {
                            Button {
                                showPhotoLibrary = true
                                arViewContainer.arView.session.pause()
                            } label: {
                                Image(uiImage: thumbnail!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit )
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        } else {
                            Button {
                                showPhotoLibrary = true
                                arViewContainer.arView.session.pause()
                            } label: {
                                Image("ExampleCat")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 65, height: 65)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    
                    Spacer()
                    
                    Button {
                        if soundOn {
                            SoundPlayer.soundPlayer.play(fileName: "ShutterSound")
                        }
                        
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
                            takeSnapShot(position: geoPosition, width: geoWidth, height: geoHeight) { croppedImage in
                                tempSnapShot = croppedImage
                            }
                        }
                        
                        loadPHAsset()
                        
                        
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
                    
                    Button("") {
                        
                    }
                    .frame(width: 65, height: 65)
                }
                .padding(30)
                .frame(maxWidth: .infinity)
                .background(.black)
                .onAppear {
                    Task {
                        try await setPhotoLibraryImage() { image in
                            thumbnail = image
                        }
                    }
                }
                
            }
            
            PhotoLibraryView(showPhotoLibrary: $showPhotoLibrary, arViewContainer: arViewContainer, loadedItem: loadedItem)
                .opacity(showPhotoLibrary ? 1 : 0)
            
        }
        .fullScreenCover(item: $tempSnapShot) { image in
            ZStack {
                Color(.black)
                
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    
                    HStack(alignment: .center) {
                        Button {
                            Task {
                                try await arViewContainer.arView.saveSnapShot(snapShot: image)
                                try await setPhotoLibraryImage() { image in
                                    DispatchQueue.main.async {
                                        thumbnail = image
                                    }
                                    print(thumbnail)
                                }
                                loadPHAsset()
                                tempSnapShot = nil
                            }
                        } label : {
                            Text("Save")
                        }
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Button {
                            Task {
                                try await setPhotoLibraryImage() { image in
                                    DispatchQueue.main.async {
                                        thumbnail = image
                                    }
                                    print(thumbnail)
                                }
                                tempSnapShot = nil
                            }
                            
                        } label: {
                            Text("Delete")
                        }
                        .padding()
                        .background(.secondary)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .foregroundColor(.white)
                    }
                }
            }
            .ignoresSafeArea(.all)
        }
        
    }
    
    func loadPHAsset() {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchPhotos = PHAsset.fetchAssets(with: fetchOption)
        loadedItem = fetchPhotos
    }
    
//    func takeSnapShot(position: CGPoint, width: CGFloat, height: CGFloat, completionHandler: @escaping (UIImage) -> Void ) {
//
//        self.arViewContainer.arView.snapshot(saveToHDR: false) { (image) in
//                let compressedImage = UIImage(data: (image?.pngData())!)
//                completionHandler(compressedImage!)
//            }
//        }
    
    func takeSnapShot(position: CGPoint, width: CGFloat, height: CGFloat, completionHandler: @escaping (UIImage) -> Void ) {
        
        let tempImage = self.arViewContainer.arView.snapshot()
        completionHandler(tempImage)
    }
    
    func setPhotoLibraryImage(completion: @escaping (UIImage?) -> Void) async {
        let fetchOption = PHFetchOptions()
        fetchOption.fetchLimit = 1
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchPhotos = PHAsset.fetchAssets(with: fetchOption)
        if let photo = fetchPhotos.firstObject {
           try await DispatchQueue.global(qos: .userInteractive).async {
                ImageManager.shared.requestImage(from: photo, thumbnailSize: CGSize(width: 40, height: 40)) { image in
//                    thumbnail = image
                    print(image)
                    completion(image)
                }
            }
        }
    }
}
    

extension UIImage {
    func crop(rect: CGRect) -> UIImage? {
        var scaledRect = rect
        scaledRect.origin.x *= scale
        scaledRect.origin.y *= scale
        scaledRect.size.width *= scale
        scaledRect.size.height *= scale
        
        guard let imageRef: CGImage = cgImage?.cropping(to: scaledRect) else {
            return nil
        }
        
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation )
    }
}

extension UIImage: Identifiable {
    public var id: String {
        UUID().uuidString
    }
}

extension ARSCNView {
    func saveSnapShot(snapShot: UIImage) {
        UIImageWriteToSavedPhotosAlbum(snapShot, nil, nil, nil)
    }

    
    func reRun() {
        let config = ARWorldTrackingConfiguration()
        config.frameSemantics = .personSegmentationWithDepth
        
        self.session.run(config)
    }
}




struct CameraFrameView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFrameView()
    }
}
