//
//  OnBoardingModel.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/14.
//

import SwiftUI

struct OnBoarding: Identifiable, Hashable {
    let description: String
    let image: String
    let id: Int
}

let onBoardingData: [OnBoarding] = [OnBoarding(description: "지도와 함께 스팟의 정보를 볼 수 있다.", image: "mapView", id: 0),
                                    OnBoarding(description: "스팟에 도착해서 필터를 해금해보세요!", image: "filterView", id: 1),
                                    OnBoarding(description: "포동네컷 프레임으로 여행을 추억해보세요.", image: "podongFourCut", id: 2)]
