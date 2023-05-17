//
//  FourCutStudioView.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/11.
//

import SwiftUI
import PhotosUI

struct FourCutStudioView: View {
    @State private var image1: UIImage?
    @State private var image2: UIImage?
    @State private var image3: UIImage?
    @State private var image4: UIImage?
    
    private var isImageAllSelected: Bool {
        return image1 != nil && image2 != nil && image3 != nil && image4 != nil
    }

    
    @State private var showImagePicker = false
    @State private var selectedTag = 0
    
    @State private var image1Tapped = false
    @State private var image2Tapped = false
    @State private var image3Tapped = false
    @State private var image4Tapped = false
    
    @State private var showingSelectingAlert = false
    
    @State var frameColor : Int = 1
    var frameName: String {
        switch frameColor {
        case 1:
            return "podong4cutFrame1"
        case 2:
            return "podong4cutFrame2"
        case 3:
            return "podong4cutFrame3"
        case 4:
            return "podong4cutFrame4"
        case 5:
            return "podong4cutFrame5"
        case 6:
            return "podong4cutFrame6"
        default:
            return "podong4cutFrame1"
        }
    }
    
    let spacing: CGFloat = 20
    
    var body: some View {
        
        ZStack{
           
            
            VStack{
                
                //MARK: - 네컷 프레임
                
                Group{
                    
                    let photoSize: CGSize = CGSize(width: 138.87, height: 185.15)
                    let topMargin: CGFloat = 54
                    let spacing: CGFloat = 6.64
                    let frameSize: CGSize = CGSize(width: 330, height: 491.49)
                    
                    VStack{
                        Spacer()
                        ZStack{
                            // 사진 프레임 디자인
                            Image(frameName)
                                .resizable()
                                .frame(width: frameSize.width, height: frameSize.height)
                                .scaledToFill()
                                .shadow(color: Color(hex: "000000", opacity: 0.3),radius: 10)
                            
                            HStack(spacing: spacing){
                                // 사진 선택 영역 - 1번, 2번
                                VStack(spacing: spacing){
                                    
                                    //MARK: - 1번 사진 영역
                                    ZStack{
                                        
                                        if let image = image1{
                                            
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: photoSize.width, height: photoSize.height)
                                                .clipped()
                                                .onTapGesture {
                                                    toggleImageTapped(num: 1)
                                                }
                                            
                                            if image1Tapped{
                                                Rectangle()
                                                    .fill(Color(hex: "000000", opacity: 0.5))
                                                    .onTapGesture {
                                                        self.image1Tapped = false
                                                    }
                                                Image(systemName: "trash.circle.fill")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                                    .onTapGesture {
                                                        self.image1Tapped = false
                                                        self.image1 = nil
                                                    }
                                                
                                            }
                                            
                                        }else{
                                            
                                            ZStack{
                                                Rectangle()
                                                    .fill(.gray)
                                                
                                                
                                                Image(systemName: "photo.circle")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                            }
                                            .onTapGesture {
                                                
                                                self.selectedTag = 1
                                                self.showImagePicker = true
                                                
                                            }
                                            
                                        }
                                    }
                                    .frame(width: photoSize.width, height: photoSize.height)
                                    
                                    
                                    //MARK: - 2번 사진 영역
                                    ZStack{
                                        
                                        if let image = image2{
                                            
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: photoSize.width, height: photoSize.height)
                                                .clipped()
                                                .onTapGesture {
                                                    toggleImageTapped(num: 2)
                                                }
                                            
                                            if image2Tapped{
                                                Rectangle()
                                                    .fill(Color(hex: "000000", opacity: 0.5))
                                                    .onTapGesture {
                                                        self.image2Tapped = false
                                                    }
                                                Image(systemName: "trash.circle.fill")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                                    .onTapGesture {
                                                        self.image2Tapped = false
                                                        self.image2 = nil
                                                    }
                                                
                                            }
                                            
                                        }else{
                                            
                                            ZStack{
                                                Rectangle()
                                                    .fill(.gray)
                                                
                                                
                                                Image(systemName: "photo.circle")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                            }
                                            .onTapGesture {
                                                
                                                self.selectedTag = 2
                                                self.showImagePicker = true
                                                
                                            }
                                            
                                        }
                                    }
                                    .frame(width: photoSize.width, height: photoSize.height)
                                    
                                }
                                // 사진 선택 영역 - 3번, 4번
                                VStack(spacing: spacing){
                                    
                                    //MARK: - 3번 사진
                                    ZStack{
                                        
                                        if let image = image3{
                                            
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: photoSize.width, height: photoSize.height)
                                                .clipped()
                                                .onTapGesture {
                                                    toggleImageTapped(num: 3)
                                                }
                                            
                                            if image3Tapped{
                                                Rectangle()
                                                    .fill(Color(hex: "000000", opacity: 0.5))
                                                    .onTapGesture {
                                                        self.image3Tapped = false
                                                    }
                                                Image(systemName: "trash.circle.fill")
                                                    .resizable()
                                                    .frame(width: 44, height: 44)
                                                    .foregroundColor(.white)
                                                    .onTapGesture {
                                                        self.image3Tapped = false
                                                        self.image3 = nil
                                                    }
                                                
                                            }
                                            
                                        }else{
                                            
                                            ZStack{
                                                Rectangle()
                                                    .fill(.gray)
                                                
                                                
                                                Image(systemName: "photo.circle")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                            }
                                            .onTapGesture {
                                                
                                                self.selectedTag = 3
                                                self.showImagePicker = true
                                                
                                            }
                                            
                                        }
                                    }
                                    .frame(width: photoSize.width, height: photoSize.height)
                                    
                                    
                                    //MARK: - 4번 사진
                                    ZStack{
                                        
                                        if let image = image4{
                                            
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: photoSize.width, height: photoSize.height)
                                                .clipped()
                                                .onTapGesture {
                                                    toggleImageTapped(num: 4)
                                                }
                                            
                                            if image4Tapped{
                                                Rectangle()
                                                    .fill(Color(hex: "000000", opacity: 0.5))
                                                    .onTapGesture {
                                                        self.image4Tapped = false
                                                    }
                                                Image(systemName: "trash.circle.fill")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                                    .onTapGesture {
                                                        self.image4Tapped = false
                                                        self.image4 = nil
                                                    }
                                                
                                            }
                                            
                                        }else{
                                            
                                            ZStack{
                                                Rectangle()
                                                    .fill(.gray)
                                                
                                                
                                                Image(systemName: "photo.circle")
                                                    .resizable()
                                                    .foregroundColor(.white)
                                                    .frame(width: 44, height: 44)
                                            }
                                            .onTapGesture {
                                                
                                                self.selectedTag = 4
                                                self.showImagePicker = true
                                                
                                            }
                                            
                                        }
                                    }
                                    .frame(width: photoSize.width, height: photoSize.height)
                                    
                                }
                                
                            }
                            .padding(.top, topMargin)
                            .frame(height: frameSize.height)
                            
                            
                        }//】 ZStack
                        .frame(width: frameSize.width, height: frameSize.height)
                        
                        // 프레임 선택 버튼
                        FrameChooseButtonView(frameColor : $frameColor)
                            .padding(.top,16)
                            .padding(.bottom,5)
                    }//】 VStack
                }//】 Group
                
                
                
                //MARK: - 출력 버튼
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.black)
                        .frame(width: 256, height: 50)
                        .shadow(color: Color(hex: "000000", opacity: 0.5),radius: 10)
                    
                    HStack{
                        
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.white)
                        
                        Text("공유하기")
                            .foregroundColor(.white)
                        
                    }//】 HStack
                    
                }//】 ZStack
                .opacity(isImageAllSelected ? 1.0 : 0.5)
                .padding()
                .onTapGesture {
                    
                    if let image = createFourCutImage() {
                        
                        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true)
                        
                    }else{
                        showingSelectingAlert = true
                        
                    }
                    
                }
                .alert(isPresented: $showingSelectingAlert) {
                    
                    Alert(title: Text("포동네컷이 \n아직 완성되지 않았어요!"), dismissButton: .default(Text("확인")))
                    
                }
                
                
            }//】 VStack
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    switch self.selectedTag {
                    case 1:
                        self.image1 = image
                    case 2:
                        self.image2 = image
                    case 3:
                        self.image3 = image
                    case 4:
                        self.image4 = image
                    default:
                        break
                    }
                    
                    self.showImagePicker = false
                }
            }//】 Sheet
            
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.white)
                    .shadow(color: Color(hex: "000000", opacity: 0.2),radius: 10)
                    .frame(width: 340,height: 40)
                
                Text(" 📣 포동네컷을 완성해보세요!")
                    .foregroundColor(.black)
            }//】 ZStack
            .vTop()
            .hCenter()
            .padding(.top,10)
            
        }//】 ZStack
        
    }//】 Body
    
    private func createFourCutImage() -> UIImage? {
        guard let image1 = image1, let image2 = image2, let image3 = image3, let image4 = image4 else {
            return nil
        }
        
        let size = CGSize(width: 627, height: 836)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1490, height: 2219))
        let image = renderer.image { ctx in
            let bgFrame = CGRect(x: 0, y: 0, width: 1490, height: 2219)
            UIImage(named: frameName)?.draw(in: bgFrame)
            
            let rect1 = CGRect(x: 103, y: 375, width: 627, height: 836)
            let rect2 = CGRect(x: 103, y: 1241, width: 627, height: 836)
            let rect3 = CGRect(x: 760, y: 375, width: 627, height: 836)
            let rect4 = CGRect(x: 760, y: 1241, width: 627, height: 836)
            
            
            let croppedImage1 = createCroppedImage(originalImage: image1, cropSize: size)
            let croppedImage2 = createCroppedImage(originalImage: image2, cropSize: size)
            let croppedImage3 = createCroppedImage(originalImage: image3, cropSize: size)
            let croppedImage4 = createCroppedImage(originalImage: image4, cropSize: size)
            
            
            croppedImage1?.draw(in: rect1)
            croppedImage2?.draw(in: rect2)
            croppedImage3?.draw(in: rect3)
            croppedImage4?.draw(in: rect4)
            
        }
        
        return image
    }
    
    private func createCroppedImage(originalImage: UIImage, cropSize: CGSize) -> UIImage?{
        
        
        let renderer = UIGraphicsImageRenderer(size: cropSize)
        
        let image = renderer.image { ctx in
            
            let cropRect = createCropRect(imageSize: originalImage.size)
            
            //CGImage 변환 목적: UIImage에는 없는 Cropping 메소드 사용하기 위함
            guard let originalCGImageCropped = originalImage.fixOrientation().cgImage?.cropping(to: cropRect) else{
                return
            }
            
            let croppedImage = UIImage(cgImage: originalCGImageCropped)
            
            croppedImage.draw(in: CGRect(origin: .zero, size: cropSize))
            
        }
        
        return image
        
    }
    
    private func createCropRect(imageSize: CGSize) -> CGRect{
        //image의 크기를 기준으로 AspectFill을 만족하는 CropRec 반환
        
        let aspectRatio: CGFloat = 3.0 / 4.0
        var cropRect: CGRect
        
        if imageSize.width / imageSize.height > aspectRatio {
            //가로가 더 길다?
            //세로를 기준으로 가로 자르기~
            let heigth = imageSize.height
            let width = heigth * aspectRatio
            let x = (imageSize.width - width) / 2
            cropRect = CGRect(x: x, y: 0, width: width, height: heigth)
            
        }else{
            //세로가 더 길다?
            //가로를 기준으로 세로 자르기~
            let width = imageSize.width
            let heigth = width / aspectRatio
            let y = (imageSize.height - heigth) / 2
            cropRect = CGRect(x: 0, y: y, width: width, height: heigth)
            
        }
        
        return cropRect
    }
    
    private func toggleImageTapped(num: Int) {
        switch num {
        case 1:
            image1Tapped.toggle()
            if image1Tapped {
                image2Tapped = false
                image3Tapped = false
                image4Tapped = false
            }
        case 2:
            image2Tapped.toggle()
            if image2Tapped {
                image1Tapped = false
                image3Tapped = false
                image4Tapped = false
            }
        case 3:
            image3Tapped.toggle()
            if image3Tapped {
                image1Tapped = false
                image2Tapped = false
                image4Tapped = false
            }
        case 4:
            image4Tapped.toggle()
            if image4Tapped {
                image1Tapped = false
                image2Tapped = false
                image3Tapped = false
            }
        default:
            break
        }
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    typealias SourceType = UIImagePickerController.SourceType
    typealias CompletionHandler = (UIImage) -> Void
    
    let sourceType: SourceType
    let completionHandler: CompletionHandler
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler: completionHandler)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let completionHandler: CompletionHandler
        
        init(completionHandler: @escaping CompletionHandler) {
            self.completionHandler = completionHandler
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                completionHandler(image)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
struct FourCutStudioView_Previews: PreviewProvider {
    static var previews: some View {
        FourCutStudioView()
    }
}

extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }

        var transform = CGAffineTransform.identity

        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -CGFloat.pi / 2)
        default:
            break
        }

        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }

        if let cgImage = self.cgImage,
           let colorSpace = cgImage.colorSpace,
           let context = CGContext(
               data: nil,
               width: Int(self.size.width),
               height: Int(self.size.height),
               bitsPerComponent: cgImage.bitsPerComponent,
               bytesPerRow: 0,
               space: colorSpace,
               bitmapInfo: cgImage.bitmapInfo.rawValue
           ) {
            context.concatenate(transform)

            switch self.imageOrientation {
            case .left, .leftMirrored, .right, .rightMirrored:
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
            default:
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
            }

            if let newCGImage = context.makeImage() {
                let newImage = UIImage(cgImage: newCGImage)
                return newImage
            }
        }

        return self
    }
}
