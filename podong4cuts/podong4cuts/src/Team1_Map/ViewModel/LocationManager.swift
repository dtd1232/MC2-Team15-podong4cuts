//
//  LocationManager.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/11.
//

import MapKit
import CoreLocation

class LocationManager: NSObject,CLLocationManagerDelegate, ObservableObject {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    //내 위치 변할때마다 실행되는 것 같음
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        locations.last.map {
//            region = MKCoordinateRegion(
//                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
//                span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
//            )
//        }
//    }
}
