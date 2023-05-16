//
//  PodongModel.swift
//  Podaong TY
//
//  Created by Koo on 2023/05/05.
//

import SwiftUI

// AppData
struct AppData: Identifiable, Codable, Hashable {
    
    let number : Int
    var id : String
    let name : String
    let hashtag : String
    let postScript : String
    let location : String
    let gallary : [String]
    let cover : String
    var isOpened: Bool
    let latitude: Double
    let longitude: Double
   
    //Sample 데이터
    static let sampleAppData = AppData(
        number: 0,
        id: "spacewalk",
        name: "스페이스워크",
        hashtag:"#스페이스워크 #스페이스워크",
        postScript: "스페이스워크 후기 ⭐️⭐️⭐️⭐️⭐️",
        location: "스페이스워크 주소",
        gallary: ["spacewalk-1", "spacewalk-2", "spacewalk-3"],
        cover : "cover-spacewalk",
        isOpened: false,
        latitude: 36.06149,
        longitude: 129.38306
    )//: Sample
    
}//: AppData
