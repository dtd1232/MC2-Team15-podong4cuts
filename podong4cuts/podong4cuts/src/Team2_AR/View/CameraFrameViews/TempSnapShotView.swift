//
//  TempSnapShotView.swift
//  CameraViewFinal
//
//  Created by user on 2023/05/13.
//

import SwiftUI

struct TempSnapShotView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var thumbnail: UIImage?
    var tempSnapShot: UIImage?
    
    var body: some View {
        ZStack {
            Color(.black)
            
            VStack {
                
                // temp snapshot image view
                if tempSnapShot != nil {
                    Image(uiImage: tempSnapShot!)
                        .resizable()
                        .scaledToFit()
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                }
                
                
                // bottom button bar
                HStack(alignment: .center) {
                    // delete button
                    Button {
                        dismiss()
                    } label: {
                        Text("삭제 하기")
                    }
                    .padding()
                    .background(.gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.red)
                    
                    // save button
                    Button {
                        UIImageWriteToSavedPhotosAlbum(tempSnapShot!, nil, nil, nil)
                        thumbnail = tempSnapShot
                        dismiss()
                    } label : {
                        Text("앨범에 저장")
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .fixedSize(horizontal: true, vertical: true)
            }
        }
        .ignoresSafeArea(.all)
//        .onAppear {
//            arViewContainer.arView.session.pause()
//        }
//        .onDisappear {
//            arViewContainer.arView.reRun()
//        }
    }
}

//struct TempSnapShotView_Previews: PreviewProvider {
//    static var previews: some View {
//        TempSnapShotView(thumbnail: nil)
//    }
//}


