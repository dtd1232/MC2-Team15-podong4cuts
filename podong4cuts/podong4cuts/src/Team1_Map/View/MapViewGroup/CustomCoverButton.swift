//
//  CustomCoverButton.swift
//  podong4cuts
//
//  Created by Koo on 2023/05/11.
//

import SwiftUI

struct CustomCoverButton: View {
    
    //property
    @ObservedObject var VM: PodongViewModel
    var selectedNumber : Int = 0
    
    var body: some View {
            

                
                
        VStack(spacing: 0){
            ZStack{
                
                Circle()
                    .frame(width: 50)
                    .foregroundColor(VM.spotdata[selectedNumber].isOpened ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
                    .shadow(color: Color.gray.opacity(0.7),radius: 5, y:6)
                
                Circle()
                    .frame(width: 45)
                    .foregroundColor(.white)
                            
                
                Image(VM.spotdata[selectedNumber].cover)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            }//: ZStack
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(VM.spotdata[selectedNumber].isOpened ? Color.green.opacity(0.8) : Color.red.opacity(0.8))
                .rotationEffect(Angle(degrees: 180))
                .frame(width: 10, height: 10)
                .offset(y: -3)
            
            Text(VM.spotdata[selectedNumber].name)
                .foregroundColor(.gray)
                .font(.headline)
                .fontWeight(.bold)
        }//: VStack
        
        
    }//】 Body
}

struct CustomCoverButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomCoverButton(VM: PodongViewModel(), selectedNumber: 0)
    }
}

