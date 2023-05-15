//
//  OnBoardingFirstPage.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/14.
//

import SwiftUI

struct OnBoardingPage: View {
    let description: String
    let image: String
    let id: Int
    @Binding var showOnBoarding: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text(description)
                                .padding(.top, proxy.size.height / 7)
                                .font(.system(size: 20, weight: .bold))
                            
                            Image(image)
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.black)
                }
            
                VStack {
                    Spacer()
                    
                    VStack {
                        OnBoardingButtonView(showOnBoarding: $showOnBoarding)
                            .padding(.top)
                    }
                    .frame(height: proxy.size.height / 6)
                    .opacity(id == 2 ? 1 : 0)
                }
        }
        .ignoresSafeArea()
        .background {
            Color.white
        }
    }
        
        
    }
}
