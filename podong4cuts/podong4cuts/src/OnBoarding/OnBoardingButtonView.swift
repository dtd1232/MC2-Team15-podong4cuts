//
//  OnBoardingButtonView.swift
//  podong4cuts
//
//  Created by Song Jihyuk on 2023/05/14.
//

import SwiftUI

struct OnBoardingButtonView: View {
    @Binding var showOnBoarding: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.0), Color.white.opacity(1)]), startPoint: .top, endPoint: .bottom)
                    .frame(height: 50)
                
                Color.white
                    .frame(height: 250)
            }
        
        VStack {
            HStack {
                Spacer()
                
                Button {
                    withAnimation(.easeInOut) {
                        self.showOnBoarding = false
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.green)
                        .frame(width: 300, height: 60)
                        .overlay {
                            Text("시작하기")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 120)
                        
                }
                
                Spacer()
            }
        }
    }
    }
}
