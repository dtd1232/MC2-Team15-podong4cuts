//
//  FrameExtension.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/11.
//

import SwiftUI

// 여러가지 디바이스에 맞게 스크린 사이즈를 맞춰줌
// MARK: - ResponsiveScreen
extension CGFloat{
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
}

// 화면을 '상.중.하 - 좌.중.우' 로 나눠서 미리 설정값을 선언해놓음
// MARK: = Frame Modifier
extension View {
    // Vertical Center
    func vCenter() -> some View {
        self.frame(maxHeight: .infinity, alignment: .center)
    }
    
    // Vertical Top
    func vTop() -> some View {
        self.frame(maxHeight: .infinity, alignment: .top)
    }
    
    // Vertical Bottom
    func vBottom() -> some View {
        self.frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    // Horizontal Center
    func hCenter() -> some View {
        self.frame(maxWidth: .infinity, alignment: .center)
    }
    
    // Horizontal Leading
    func hLeading() -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // Horizontal Trailing
    func hTrailing() -> some View {
        self.frame(maxWidth: .infinity, alignment: .trailing)
    }
}
