//
//  DetailView.swift
//  Podaong TY
//
//  Created by Koo on 2023/05/04.
//


import SwiftUI

struct DetailView: View {
    
    //property
    @ObservedObject var VM: PodongViewModel
    
    
    var selectedNumber: Int = 0
   
    
    var body: some View {
        VStack{
            
            //상단 영역
            HStack{
                //이름& 해시태그
                VStack{
                    HStack{
                        Text(VM.spotdata[selectedNumber].name)
                            .font(.title)
                            .foregroundColor(.black)
                            .fontWeight(.heavy)
                            .padding(.vertical, 5)
                        
                        Image(systemName: VM.spotdata[selectedNumber].isOpened ? "lock.open.fill" : "lock.fill")
                            .font(.title2)
                            .foregroundColor(
                                VM.spotdata[selectedNumber].isOpened ? .gray.opacity(0.1) : .gray.opacity(0.9)
                            )
                            .animation(.easeInOut(duration: 0.2), value: VM.spotdata[selectedNumber].isOpened)
                        
                        
                        Spacer()
                        
                    }//】 HStack
                    Text(VM.spotdata[selectedNumber].hashtag)
                        .font(.headline)
                        .foregroundColor(.gray.opacity(0.8))
                        .hLeading()
                }//: VStack
                
                // 남은거리
//                ZStack{
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color.gray.opacity(0.2))
//                        .frame(width: 90, height: 60)
//                    HStack{
//                        Image(systemName:"mappin.and.ellipse")
//
//                        Text("17m")
//                            .font(.title3)
//                            .fontWeight(.heavy)
//                            .foregroundColor(Color.gray.opacity(0.9))
//                    }//: HStack
//                }//: ZStack (남은거리)
                
            }//: HStack (프로필 상단영역)
            .padding()
            .background(.white)
            .shadow(color: Color.gray.opacity(0.2), radius: 10, y:5)
            
            ZStack{
                //하단 영역
                ScrollView(showsIndicators: false){
                    VStack(spacing: 5){
                        //1. 사진
                        TabView{
                            ForEach(VM.spotdata[selectedNumber].gallary, id:\.self){index in
                                Image(index)
                                    .resizable()
                                    .scaledToFit()
                                    .scaledToFill()
                            }//: Loop
                        }//: TabView
                        .tabViewStyle(.page)
                        .frame(width: 350, height: 350)
                        .clipShape (RoundedRectangle(cornerRadius: 15))
                        Spacer()
                        
                        //2. 후기
                        VStack(spacing: 10){
                            Text("[ 포동 후기 ]")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text(VM.spotdata[selectedNumber].postScript)
                            
                        }//: VStack
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(15)
                        
                        
                        Spacer()
                        
                        //3. 상세위치
                        ZStack{
                            VStack(spacing: 10){
                                Text("[ 스팟 주소 ]")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                ZStack{
                                    Text(VM.spotdata[selectedNumber].location)
                                        .hCenter()
                                    
                                }//: ZStack
                            }//: VStack
                            
//                            Button {
//                                <#code#>
//                            } label: {
//                                ZStack{
//                                    RoundedRectangle(cornerRadius: 10)
//                                        .foregroundColor(Color.gray.opacity(0.2))
//                                        .frame(width: 40, height: 50)
//                                    Image(systemName: "doc.on.doc.fill")
//                                        .fontWeight(.heavy)
//                                        .foregroundColor(.gray)
//                                }//: ZStack
//                                .frame(width: 40)
//                                .hTrailing()
//                            }
                            
                        }//: ZStack
                        .padding(20)
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.bottom, 100)
                        
                        
                        
                    }//: VStack
                }//: Scroll
                .shadow(color: Color.gray.opacity(0.3), radius: 10, y: 3)
                
                Button {
                    VM.spotdata[selectedNumber].isOpened = true
                    //TODO: 현재 위치와 비교해서 해금하는 로직 (Noah)
                } label: {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 330, height: 50)
                        .overlay {
                            HStack(spacing: 30){
                                
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text("고래 만나러 가기")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                            }
                        }
                }//】 Button
                .padding(.bottom, 5)
                .vBottom()
            }//】 ZStack
        }//: VStack
    }//: Body
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(VM: PodongViewModel(), selectedNumber: 0)
           
    }
}
