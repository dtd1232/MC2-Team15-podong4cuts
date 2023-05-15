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
                    Image("ExampleCat")
                        .resizable()
                        .scaledToFit()
                }
                
                
                // bottom button bar
                HStack(alignment: .center) {
                    
                    // save button
                    Button {
                        UIImageWriteToSavedPhotosAlbum(tempSnapShot!, nil, nil, nil)
                        thumbnail = tempSnapShot
                        dismiss()
                    } label : {
                        Text("Save")
                    }
                    .padding()
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    
                    // delete button
                    Button {
                        dismiss()
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


