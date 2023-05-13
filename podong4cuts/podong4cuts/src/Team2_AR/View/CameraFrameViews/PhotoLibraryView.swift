//
//  PhotoLibraryView.swift
//  CameraViewFinal
//
//  Created by user on 2023/05/13.
//

import SwiftUI
import PhotosUI

struct PhotoLibraryView: View {
    @State private var loadedItem: PHFetchResult<PHAsset> = PHFetchResult()
    @State private var showDetailImage = false
    @State private var detailImage: UIImage?
    
    var requestImageOption = PHImageRequestOptions()
    var arViewContainer: TempARViewContainer

    var columns: [GridItem] {
        return Array(repeating: .init(.flexible()), count: 3)
    }
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<loadedItem.count, id: \.self) { index in
                            let thumbnailImage =  fetchThumbnailImage(index: index)
                            
                            if thumbnailImage != nil {
                                Image(uiImage: thumbnailImage!)
                                    .onTapGesture {
                                        detailImage = fetchDetailImage(index: index)
                                        showDetailImage = true
                                    }
                            } else {
                                Image("ExampleCat")
                                }
                            }
                        }
                    }
                    NavigationLink("", isActive: $showDetailImage) {
                        DetailImageView(detailImage: detailImage)
                    }
                }
            .onAppear {
                setRequestImageOptions()
                setPhotoLibraryImage()
            }
        }
        .background(.black)
        .onAppear {
            arViewContainer.arView.session.pause()
        }
        .onDisappear {
            arViewContainer.arView.reRun()
        }
    }
    
    func setPhotoLibraryImage() {
        let fetchOption = PHFetchOptions()
        fetchOption.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let fetchPhotos = PHAsset.fetchAssets(with: fetchOption)
        loadedItem = fetchPhotos
    }
    
    func fetchThumbnailImage(index: Int) -> UIImage? {
        var returnImage: UIImage?

        if index > loadedItem.count - 1 {
            print("List index out of bound")
            return nil
        }

        ImageManager.shared.requestImage(from: loadedItem[index], thumbnailSize: CGSize(width: 40, height: 40)) { image in
            returnImage = image
        }

        return returnImage
    }
    
    func fetchDetailImage(index: Int) -> UIImage? {
        var detailImage: UIImage?

        if index > loadedItem.count - 1 {
            print("List index out of bound")
            return nil
        }
        

        ImageManager.shared.requestDetailImage(from: loadedItem[index], thumbnailSize: CGSize(width: 40, height: 40)) { image in
            detailImage = image
        }
        
        return detailImage!
    }
    
    func setRequestImageOptions() {
        requestImageOption.isSynchronous = true
        requestImageOption.deliveryMode = .highQualityFormat
        requestImageOption.resizeMode = PHImageRequestOptionsResizeMode.exact
    }

}

//struct PhotoLibraryView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoLibraryView(showPhotoLibrary: Binding(true))
//    }
//}


extension GridItem: Hashable {
    public static func == (lhs: GridItem, rhs: GridItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    public var identifier: String {
        return UUID().uuidString
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(identifier)
    }

}


struct DetailImageView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var detailImage: UIImage?
    
    var body: some View {
        ZStack {
            Color(.black)
            
            if detailImage != nil {
                Image(uiImage: detailImage!)
                    .resizable()
                    .scaledToFit()
            } else {
                Image("ExampleImage")
                    .resizable()
                    .scaledToFit()
            }
        }
        .ignoresSafeArea(.all)
        .onTapGesture {
            dismiss()
        }
    }
}


