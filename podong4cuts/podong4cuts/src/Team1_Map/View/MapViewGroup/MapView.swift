//
//  MapView.swift
//  podong4cuts
//
//  Created by BAE on 2023/05/05.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    //    @State private var region = MKCoordinateRegion(
    //        center: CLLocationCoordinate2D(latitude: 36.058616, longitude: 129.382959),
    //        span: MKCoordinateSpan(latitudeDelta: 0.015,
    //                               longitudeDelta: 0.015))
    //    @State var offset: CGFloat = 0
    @State var tracking: MapUserTrackingMode = .follow
    //    MapView Reload 해야할 시 아래 variable 주석 해제 후 .id(reloadMapView)
    //    @State private var reloadMapView = false
    @StateObject var manager = LocationManager()
    @State private var currentLocationManager = CLLocationManager()
//    @State private var annotations: [CoverButton] = []
    
    //goopy's code
    @ObservedObject var VM: PodongViewModel
    @State private var selectedSpot: AppData? = nil
    //    @State var isDetailSheetPresented : Bool = false
    @State var showDefaultCameraFrameView = false
    @State var cameraFrameNumber = 0
    
    @EnvironmentObject var cameraViewModel: CameraViewModel
    var body: some View {
        NavigationView{
            ZStack{
                // [2] Map Struct로 구현.
                Map(coordinateRegion: $manager.region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $tracking,
                    annotationItems: VM.spotdata) { locations in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: locations.latitude, longitude: locations.longitude)) {
                        CustomCoverButton(VM: self.VM, selectedNumber: locations.number)
                            .onTapGesture {
                                selectedSpot = VM.spotdata[locations.number]
                            }//: onTapDesture
//                            .scaleEffect(VM.spotdata[locations.selectedNumber].isDetailSheetPresented ? 1 : 0.5)
                    }
                }
//                    .onAppear {
//                        addAnnotations()
//                    }
                    .edgesIgnoringSafeArea(.top)
                
                HStack {
                    ZStack(alignment: .leading) {
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundColor(.white)
                                .shadow(color: Color(hex: "000000", opacity: 0.2),radius: 10)
                                .frame(width:340, height: 50)
                            
                            Text("필터 스팟으로 이동해주세요!")
                        }// 상단 안내문
                        .vTop()
                        .hCenter()
                        .padding(.top,10)

                        VStack{
                            // (1) 내 위치로 이동 버튼
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 42, height: 42)
                                
                                //TODO : 애플 지도 참조해서 버튼 디자인 리팩토링
                                Button(action: {
                                    focusOnUserLocation()
                                }) {
                                    Image(systemName: "location.circle.fill")
                                }
                                .font(.system(size: 45))
                                .foregroundColor(Color.black)
                            }
                            .padding([.top], 20)
                            
                            // (2) 영일대로 이동 버튼
                            ZStack{
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 42, height: 42)
                                
                                Button (action: {
                                    withAnimation(.easeIn){
                                        manager.region.center = CLLocationCoordinate2D(latitude: 36.058616, longitude: 129.382959)
//                                        manager.region.span = MKCoordinateSpan(
//                                            latitudeDelta: 0.015,
//                                            longitudeDelta: 0.015)
                                    }
                                }) {
                                    Image(systemName: "mappin.circle.fill")
                                }
                                .font(.system(size: 45))
                                .foregroundColor(Color.black)
                            }//】 ZStack
                        }
                        .vTop()
                        .padding(.top,60)
                        
                    }//】 VStack
                    .padding([.leading], 10)
                    
                    Spacer()
//                    NavigationLink("", isActive: $showDefaultCameraFrameView) {
//                        DefaultCameraFrameView(selected: cameraFrameNumber )
//                    }
                }//】 HStack
            }//】 ZStack
        }//】 Navigation
        .sheet(item: $selectedSpot, onDismiss: nil) { data in
            
            DetailView(VM: self.VM, selectedNumber: data.number, showDefaultCameraFrameView: $showDefaultCameraFrameView, cameraFrameNumber: $cameraFrameNumber)
                .presentationDetents([.medium, .large])
                .onAppear {
                    cameraViewModel.selectedNumber = data.number
                }
        }
        
        
    }//: Struct
    
    
    // 내 위치 알려주는 함수
    func focusOnUserLocation() {
        guard let userLocation = currentLocationManager.location?.coordinate else { return }
        withAnimation(.easeIn){
            manager.region.center = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
//            manager.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015))
            
        }
    }//】 func
    
    // 맵핀 배열에 추가하는 함수
//    func addAnnotations(){
//        self.annotations = [
//
//            //[0] 스페이스워크
//            CoverButton(
//                VM: self.VM,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: self.VM.spotdata[0].latitude,
//                    longitude: self.VM.spotdata[0].longitude), selectedNumber: 0),
//
//            //[1] 토마틸로
//            CoverButton(
//                VM: self.VM,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: self.VM.spotdata[1].latitude,
//                    longitude: self.VM.spotdata[1].longitude), selectedNumber: 1),
//
////            //[2] 오브레맨
////            CoverButton(
////                VM: self.VM,
////                coordinate: CLLocationCoordinate2D(
////                    latitude: self.VM.spotdata[2].latitude,
////                    longitude: self.VM.spotdata[2].longitude), selectedNumber: 2),
//
//            //[2] 영일교
//            CoverButton(
//                VM: self.VM,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: self.VM.spotdata[2].latitude,
//                    longitude: self.VM.spotdata[2].longitude), selectedNumber: 2),
//
//            //[3] 고래꼬리
//            CoverButton(
//                VM: self.VM,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: self.VM.spotdata[3].latitude,
//                    longitude: self.VM.spotdata[3].longitude), selectedNumber: 3),
//
//            //[4] 테스트 스팟 - C5
//            CoverButton(
//                VM: self.VM,
//                coordinate: CLLocationCoordinate2D(
//                    latitude: self.VM.spotdata[3].latitude,
//                    longitude: self.VM.spotdata[3].longitude), selectedNumber: 4),
//
//        ]
//
//    }//】 func
    
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(VM: PodongViewModel())
    }
}

