//
//  CoverButton.swift
//  Podong
//
//  Created by Koo on 2023/05/05.
//

import SwiftUI
import CoreLocation
import MapKit

class CoverButton: NSObject, MKAnnotation, Identifiable {
    
    //property
    @ObservedObject var VM: PodongViewModel
    var coordinate: CLLocationCoordinate2D
    var selectedNumber: Int
    
    init(VM: PodongViewModel, coordinate: CLLocationCoordinate2D, selectedNumber: Int) {
        
        self.VM = VM
        self.coordinate = coordinate
        self.selectedNumber = selectedNumber
        
    }
    
}//: Class
