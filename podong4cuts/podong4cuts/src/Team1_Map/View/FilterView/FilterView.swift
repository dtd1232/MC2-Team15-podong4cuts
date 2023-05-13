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
    var filterNumber: Int = 0
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil ),
        GridItem(.flexible(), spacing: 0, alignment: nil )]
    
    
    var body: some View {
        
            
            LazyVGrid(columns: columns) {
//                VStack{
//                    Image("spacewalk-1")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 170, height: 180)
//                        .cornerRadius(15)
//                    Text("스페이스워크")
//                }
//
//
//                VStack{
//                    Image("tomatilo-1")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 170, height: 180)
//                        .cornerRadius(15)
//                    Text("토마틸로")
//                }
//
//                VStack{
//                    Image("bridge-1")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 170, height: 180)
//                        .cornerRadius(15)
//                    Text("영일교")
//                }
//
//                VStack{
//                    Image("whale-1")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 170, height: 180)
//                        .cornerRadius(15)
//                    Text("고래꼬리워터폴리")
//                }
                
                ForEach(VM.spotdata){ index in
                    VStack{
                        //if
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
                        Text(index.name)
                    }//】 VStack
                    .onTapGesture {
                        //TODO: 장소별 필터뷰로 이동하는 코드
                    }
                }//】 Loop
            }//】 Grid
            .padding(.horizontal)
        
    }//】 Body
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(VM: PodongViewModel())
    }
}

