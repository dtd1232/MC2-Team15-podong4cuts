//
//  FilterListView.swift
//  Podong
//
//  Created by Koo on 2023/05/05.
//

import SwiftUI

struct FilterListView: View {
    
    //property
    @ObservedObject var VM: PodongViewModel
    @State var filterNumber: Int = 0
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil ),
        GridItem(.flexible(), spacing: 0, alignment: nil )]
    
    @State private var showDefaultCameraFrameView = false
    
    var body: some View {
        
        NavigationView {
            LazyVGrid(columns: columns) {
                ForEach(VM.spotdata){ index in
                    VStack{
                        if index.isOpened == false{
                            ZStack{
                                Color.gray.opacity(0.5)

                                Image(systemName: "lock.fill")
                                    .font(.title)
                                    .foregroundColor(.black.opacity(0.3))

                                Image(index.cover)
                                    .resizable()
                                    .scaledToFill()
                                    .opacity(index.isOpened ? 1.0 : 0)

                            }//】 ZStack
                            .frame(width: 170, height: 180)
                            .cornerRadius(15)
                        }else{
                            Image(index.gallary[0])
                                .resizable()
                                .scaledToFill()
                                .frame(width: 170, height: 180)
                                .cornerRadius(15)
                        }
                        
                        Text(index.name)
                        NavigationLink("", isActive: $showDefaultCameraFrameView) {
                            DefaultCameraFrameView(selected: filterNumber)
                        }
                    }//】 VStack
                    .onTapGesture {
                        //TODO: 장소별 필터뷰로 이동하는 코드
                        print("Tapped")
                        filterNumber = index.number
                        print(filterNumber)
                        showDefaultCameraFrameView = true
                        print(showDefaultCameraFrameView)
                    }
                }//】 Loop
            }//】 Grid
            .padding(.horizontal)
            
        }// NavigationView
        
    }//】 Body
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(VM: PodongViewModel())
    }
}

