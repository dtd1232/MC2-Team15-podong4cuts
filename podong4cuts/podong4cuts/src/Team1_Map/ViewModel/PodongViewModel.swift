//
//  PodongViewModel.swift
//  Podaong TY
//
//  Created by Koo on 2023/05/05.
//

import SwiftUI

class PodongViewModel: ObservableObject {
    
    // property
    // Json 파일을 가져다 SwiftUI에서 사용할 수 있도록 []안에 저장
    @Published var spotdata: [AppData] = Bundle.main.decode("spotdata.json")
    
    @Published var selectedSpot: AppData? = nil
    

    
    
//    init(spotdata: [AppData], selectedSpot: AppData? = nil, selectedNumber: Int) {
//        self.spotdata = spotdata
//        self.selectedSpot = selectedSpot
//        self.selectedNumber = selectedNumber
//    }
    
}
