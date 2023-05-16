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
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @EnvironmentObject var arViewModel: ARViewModel
    @State var filterNumber: Int = 0
    
    @State private var showingBackAlert = false
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil ),
        GridItem(.flexible(), spacing: 0, alignment: nil )]
    
    @State private var showDefaultCameraFrameView = false
    
    var body: some View {
        NavigationView {
            ZStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.white)
                        .shadow(color: Color(hex: "000000", opacity: 0.2),radius: 10)
                        .frame(width:340 , height: 40)
                    
                    Text(" 📣 Open된 필터로 바로 이동 가능해요!")
                }//】 ZStack
                .vTop()
                .hCenter()
                .padding(.top,10)
                
                LazyVGrid(columns: columns) {
                    ForEach(VM.spotdata){ index in
                        VStack{
                            if index.number == 4 { // 아이팜은 이스터 에그로 빼놓기
                                
                            }
                            else {
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
                            }
                    }//】 VStack
                        .padding(.top, 18)
                        .frame(width: 160, height: 200)
                        .background(.white)
                        .cornerRadius(15)
                        .shadow(color: Color.gray.opacity(0.3), radius: 10, y: 3)
                        .padding(.vertical, 5)
                        .onTapGesture {
                            //TODO: 장소별 필터뷰로 이동하는 코드
                            if VM.spotdata[index.number].isOpened{
                                filterNumber = index.number
                                //                            showDefaultCameraFrameView = true
                                arViewModel.selectModel(number: filterNumber)
                                cameraViewModel.showDefaultCameraFrameView = true
                            }else{
                                showingBackAlert = true
                            }
                        }
                        .alert(isPresented: $showingBackAlert) {
                            
                            Alert(title: Text("필터가 닫혀있어요!"), message: Text("해당 스팟에 가서 \n위치를 인증해 주세요."), dismissButton: .default(Text("확인")))
                            
                        }
                    }//】 Loop
                }//】 Grid
                .vCenter()
            }//】 ZStack
            .padding(.horizontal,15)
        }// NavigationView
    }//】 Body
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(VM: PodongViewModel())
    }
}
