//
//  ImageManager.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import Photos
import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    private let imageManager = PHImageManager()
    var requestImageOption = PHImageRequestOptions()
    
    init() {
        setRequestImageOptions()
    }
    
    func requestImage(from asset: PHAsset, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        
        self.imageManager.requestImage(for: asset, targetSize: CGSize(width: 120, height: 120), contentMode: .aspectFill, options: requestImageOption) { image, info in
            completion(image)
        }
    }
    
    func requestDetailImage(from asset: PHAsset, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        self.imageManager.requestImage(for: asset, targetSize: CGSize(width: 360, height: 480), contentMode: .aspectFill, options: requestImageOption) { image, info in
            completion(image)
        }
    }
    
    func setRequestImageOptions() {
        requestImageOption.isSynchronous = true
        requestImageOption.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestImageOption.resizeMode = PHImageRequestOptionsResizeMode.exact
    }
}
