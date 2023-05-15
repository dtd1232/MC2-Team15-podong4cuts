//
//  OnBoardingView.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/14.
//

import SwiftUI

struct OnBoardingView: View {
    @State private var selection = 0
    @State private var showOnBoarding = true
    var body: some View {
        if showOnBoarding {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                TabView(selection: $selection) {
                        ForEach(onBoardingData, id: \.self) { data in
                            OnBoardingPage(description: data.description, image: data.image, id: data.id, showOnBoarding: $showOnBoarding)
                                .tag(data.id)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .onAppear {
                    // Set the flag to false after the onboarding has been shown
                    UserDefaults.standard.set(true, forKey: "onboardingShown")
                    
                }
            }
        } else {
            HomeView(VM: PodongViewModel())
        }
    }
}
