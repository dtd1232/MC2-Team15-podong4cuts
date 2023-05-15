//
//  podong4cutsApp.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/11.
//

import SwiftUI

@main
struct podong4cutsApp: App {
    // property
    @StateObject var VM: PodongViewModel = PodongViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "onboardingShown") {
                HomeView(VM: PodongViewModel())
                    .environmentObject(CameraViewModel())
            } else {
                OnBoardingView()
                    .environmentObject(CameraViewModel())
            }
        }
    }
}
