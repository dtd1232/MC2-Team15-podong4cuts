//
//  DetailView.swift
//  Podaong TY
//
//  Created by Koo on 2023/05/04.
//

import SwiftUI
import CoreLocation

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    //property
    @ObservedObject var VM: PodongViewModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @EnvironmentObject var arViewModel: ARViewModel
    
    var selectedNumber: Int = 0
   
    @Binding var showDefaultCameraFrameView: Bool
    
    @State private var showingBackAlert = false
    @State private var copiedText = ""
    @State var showCopiedAlert: Bool = false
    
    var body: some View {
        VStack{
            
            //상단 영역
            HStack{
                //이름& 해시태그
                VStack{
                    // 이름
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
                    
                    HStack(spacing: 7){
                        // 해시태그
                        Text(VM.spotdata[selectedNumber].hashtag1)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.horizontal,10)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.gray.opacity(0.1), radius: 1, y:3)
                        
                        Text(VM.spotdata[selectedNumber].hashtag2)
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding(.horizontal,10)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.gray.opacity(0.1), radius: 1, y:3)
                        Spacer()
                        
                    }//】 HStack
                }//: VStack
                
                // 남은거리
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .frame(width: 90, height: 60)
                    HStack{
                        Image(systemName:"mappin.and.ellipse")

                        let distance = compareUserLocation(locationNumber: selectedNumber)
                        
                        Text(String(format: "%.1fkm", distance/1000))
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.gray.opacity(0.9))
                    }//: HStack
                }//: ZStack (남은거리)
                
            }//: HStack (프로필 상단영역)
            .padding()
            .padding(.leading, 10)
            .background(.white)
            .shadow(color: Color.gray.opacity(0.2), radius: 10, y:5)
            
            ZStack{
                //하단 영역
                ScrollView(showsIndicators: false){
                    VStack(spacing: 5){
                        //1. 사진
                        VStack{
                            
                            HStack{
                                Text("필터 예시")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                
                               
                                Spacer()
                            }
                            
                            TabView{
                                ForEach(VM.spotdata[selectedNumber].gallary, id:\.self){index in
                                    Image(index)
                                        .resizable()
                                        .scaledToFit()
                                        .scaledToFill()
                                }//: Loop
                            }//: TabView
                            .tabViewStyle(.page)
                            .frame(width: 300, height: 350)
                            .clipShape (RoundedRectangle(cornerRadius: 15))
                            .padding(.top,5)
                            Spacer()
                            
                        }//】 VStack
                        .padding()
                        .frame(width: 350)
                        .background(.white)
                        .cornerRadius(15)
                        
                        
                        //2. 후기
                        HStack{
                            Text("포동 후기")
                                .font(.headline)
                                .fontWeight(.heavy)
                                
                            Text("•")
                                .font(.title)
                                .foregroundColor(Color.gray.opacity(0.3))
                            
                            // 니들이 게맛을 알아!
                            Text(VM.spotdata[selectedNumber].postScript)
                                .font(.footnote)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            Spacer()
                            
                        }//: VStack
                        
                        .padding()
                        .frame(width: 350, height: 70)
                        .background(.white)
                        .cornerRadius(15)
                        
                        
                        
                        
                        //3. 상세위치
                        ZStack{
                            HStack{
                                Text("스팟 주소")
                                    .font(.headline)
                                    .fontWeight(.heavy)
                                
                                Text("•")
                                    .font(.title)
                                    .foregroundColor(Color.gray.opacity(0.3))
                                    
                                
                                Text(VM.spotdata[selectedNumber].location)
                                // 경북 포항시 북구...
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    
                            }//】 HStack
                            .hLeading()
                                
                            
                            
                            // Copy Button
                            Button {
                                copiedText = VM.spotdata[selectedNumber].location
                                UIPasteboard.general.string = copiedText
                                showCopiedAlert.toggle()
                            } label: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.gray.opacity(0.2))
                                        .frame(width: 40, height: 40)
                                    Image(systemName: "doc.on.doc.fill")
                                        .fontWeight(.heavy)
                                        .foregroundColor(.gray)
                                }//: ZStack
                                .hTrailing()
                            }//】 Button
                            .alert(isPresented: $showCopiedAlert){
                                Alert(title: Text("주소가 복사 되었습니다. ").font(.headline))
                            }
                            
                        }//: HStack
                        .padding(20)
                        .frame(width: 350, height: 70)
                        .background(.white)
                        .cornerRadius(15)
                        .padding(.bottom, 100)
                        
                        
                        
                    }//: VStack
                }//: Scroll
                .shadow(color: Color.gray.opacity(0.3), radius: 10, y: 3)
                
                Button {
//                    VM.spotdata[selectedNumber].isOpened = true
                    //TODO: 현재 위치와 비교해서 해금하는 로직 (Noah)
                    // 현재 위치와 스팟 좌표 사이의 거리 반환
                    let distance = compareUserLocation(locationNumber: selectedNumber)
                    
                    if distance <= 60{
                        VM.openSpotFilter(num: selectedNumber)
                    }
                    
                    //일단 무지껀 해금 하도록
                    VM.openSpotFilter(num: selectedNumber)
                    
                    if VM.spotdata[selectedNumber].isOpened {
                        dismiss()
                        
                        cameraViewModel.showDefaultCameraFrameView = true
                        arViewModel.selectedNumber = selectedNumber
                        arViewModel.selectModel(number: selectedNumber)
                            
                        
                        
                    } else {
                        showingBackAlert = true
                    }

                } label: {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 330, height: 50)
                        .foregroundColor(Color.green)
                        .overlay {
                            HStack(spacing: 30){
                                
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text("필터 사용하기")
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
//                                switch selectedNumber{
//                                case 0:
//                                    Text("과메기 대가리")
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .fontWeight(.bold)
//                                case 1:
//                                    Text("멕시칸 코스프레")
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .fontWeight(.bold)
//                                case 2:
//                                    Text("게 잡으러 가기")
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .fontWeight(.bold)
//                                case 3:
//                                    Text("고래 만나러 가기")
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .fontWeight(.bold)
//                                default:
//                                    Text("과메기 만나러 가기")
//                                        .foregroundColor(.white)
//                                        .font(.title3)
//                                        .fontWeight(.bold)
//                                }
                            }
                        }
                }//】 Button
                .alert(isPresented: $showingBackAlert) {
                    
                    Alert(title: Text("위치 인증 실패"), message: Text("더 가까이 이동 후 다시 시도하세요"), dismissButton: .default(Text("확인")))
                    
                }
                .padding(.bottom, 5)
                .vBottom()
            }//】 ZStack

        }//: VStack
    }//: Body
    
    // 유저 위치 반환하는 함수
    func getUserLocationCoordinate() -> CLLocationCoordinate2D {
        let locationManager = CLLocationManager()
        let location = locationManager.location
        
        return location!.coordinate
    }
    
    // 현재 유저 위치와 스팟 위치 비교하는 함수
    func compareUserLocation(locationNumber: Int) -> Double {
        // 현재 유저 위치 받아오기: CLLocationCoordinate2D
        let userCoordinate = getUserLocationCoordinate()
        
        print(userCoordinate)
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        // 스팟 좌표 갖고 오기
        let spotLocation = CLLocation(latitude: self.VM.spotdata[locationNumber].latitude, longitude: self.VM.spotdata[locationNumber].longitude)
        
        // 유저위치와 스팟 위치 비교하기
        let distanceInMeters = userLocation.distance(from: spotLocation)
        
        print(distanceInMeters)
        
        return distanceInMeters
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(VM: PodongViewModel(), selectedNumber: 0, showDefaultCameraFrameView: .constant(true))
        
    }
}
