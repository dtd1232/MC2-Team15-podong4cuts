//
//  FrameChooseButtonView.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/16.
//

import SwiftUI

struct FrameChooseButtonView: View {
    
    //property
    @Binding var frameColor : Int
    @State private var frame1Choosed : String = "FrameChoosed"
    @State private var frame2Choosed : String = "FrameUnchoosed"
    @State private var frame3Choosed : String = "FrameUnchoosed"
    @State private var frame4Choosed : String = "FrameUnchoosed"
    @State private var frame5Choosed : String = "FrameUnchoosed"
    @State private var frame6Choosed : String = "FrameUnchoosed"
    
    var body: some View {
        // 프레임 선택 버튼
        HStack(spacing: 15){
        // [1]
            Button {
                frameColor = 1
                frame1Choosed = "FrameChoosed"
                frame2Choosed = "FrameUnchoosed"
                frame3Choosed = "FrameUnchoosed"
                frame4Choosed = "FrameUnchoosed"
                frame5Choosed = "FrameUnchoosed"
                frame6Choosed = "FrameUnchoosed"
                
                
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.black)
                    .background(
                        Circle()
                            .fill(Color(frame1Choosed))
                            .frame(width: 37, height: 37)
                            .shadow(color: Color.gray.opacity(0.7), radius: 5, y: 5)
                    )
                
            }//】 Button 1
            
        //[2]
                Button {
                    frameColor = 2
                    frame1Choosed = "FrameUnchoosed"
                    frame2Choosed = "FrameChoosed"
                    frame3Choosed = "FrameUnchoosed"
                    frame4Choosed = "FrameUnchoosed"
                    frame5Choosed = "FrameUnchoosed"
                    frame6Choosed = "FrameUnchoosed"
                } label: {
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.blue)
                        .background(
                            Circle()
                                .fill(Color(frame2Choosed))
                                .frame(width: 37, height: 37)
                                .shadow(color: Color.gray.opacity(0.7), radius: 5, y: 5)
                        )
                }//】 Button 2
            
        //[3]
            Button {
                frameColor = 3
                frame1Choosed = "FrameUnchoosed"
                frame2Choosed = "FrameUnchoosed"
                frame3Choosed = "FrameChoosed"
                frame4Choosed = "FrameUnchoosed"
                frame5Choosed = "FrameUnchoosed"
                frame6Choosed = "FrameUnchoosed"
            } label: {
                RoundedRectangle(cornerRadius: 50)
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color.white)
                    .background(
                        Circle()
                            .fill(Color(frame3Choosed))
                            .frame(width: 37, height: 37)
                            .shadow(color: Color.gray.opacity(0.7), radius: 5, y: 5)
                    )
            }//】 Button 3
            
        //[4]
            Button {
                frameColor = 4
                frame1Choosed = "FrameUnchoosed"
                frame2Choosed = "FrameUnchoosed"
                frame3Choosed = "FrameUnchoosed"
                frame4Choosed = "FrameChoosed"
                frame5Choosed = "FrameUnchoosed"
                frame6Choosed = "FrameUnchoosed"
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color( "FrameColor_04"))
                        .background(
                            Circle()
                                .fill(Color(frame4Choosed))
                                .frame(width: 37, height: 37)
                                .shadow(color: Color.gray.opacity(0.7), radius: 5, y: 5)
                        )
                    Image("ButtonEyes")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 17, height: 17)
                        .offset(y: -17)
                }//】 ZStack
            }//】 Button 4
            
        //[5]
            Button {
                frameColor = 5
                frame1Choosed = "FrameUnchoosed"
                frame2Choosed = "FrameUnchoosed"
                frame3Choosed = "FrameUnchoosed"
                frame4Choosed = "FrameUnchoosed"
                frame5Choosed = "FrameChoosed"
                frame6Choosed = "FrameUnchoosed"

            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color( "FrameColor_05"))
                        .background(
                            Circle()
                                .fill(Color(frame5Choosed))
                                .frame(width: 37, height: 37)
                                .shadow(color: Color.gray.opacity(0.7), radius: 5, y: 5)
                        )
                    Image("ButtonEyes")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 17, height: 17)
                        .offset(y: -17)
                }//】 ZStack
            }//】 Button 5
            
        //[6]
            Button {
                frameColor = 6
                frame1Choosed = "FrameUnchoosed"
                frame2Choosed = "FrameUnchoosed"
                frame3Choosed = "FrameUnchoosed"
                frame4Choosed = "FrameUnchoosed"
                frame5Choosed = "FrameUnchoosed"
                frame6Choosed = "FrameChoosed"

            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color( "FrameColor_06"))
                        .background(
                            Circle()
                                .fill(Color(frame6Choosed))
                                .frame(width: 37, height: 37)
                                .shadow(color: Color.gray.opacity(0.7), radius: 5, y: 5)
                        )
                    Image("ButtonEyes")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 17, height: 17)
                            .offset(y: -17)
                }//】 ZStack
            }//】 Button 6
            
            
        }//】 HStack
    }
}

struct FrameChooseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FrameChooseButtonView(frameColor: .constant(1))
    }
}
