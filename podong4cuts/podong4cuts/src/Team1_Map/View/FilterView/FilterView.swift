//
//  FilterListView.swift
//  Podong
//
//  Created by Koo on 2023/05/05.
//

import SwiftUI

struct FilterListView: View {
    
    //property
    @ObservedObject var VM: PodongViewModel
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0, alignment: nil ),
        GridItem(.flexible(), spacing: 0, alignment: nil )]
    
    
    var body: some View {
        
            
            LazyVGrid(columns: columns) {
                ForEach(VM.spotdata){ index in
                    VStack{
                        ZStack{
                            Color.gray.opacity(0.5)
                            
                            Image(systemName: "lock.fill")
                                .font(.title)
                                .foregroundColor(.black.opacity(0.3))
                            
                            Image(index.cover)
                                .resizable()
                                .scaledToFill()
                                .opacity(index.isOpened ? 1.0 : 0)
                            
                        }//】 ZStack
                        .frame(width: 170, height: 180)
                        .cornerRadius(15)
                        Text(index.name)
                    }//】 VStack
                }//】 Loop
            }//】 Grid
            .padding(.horizontal)
        
    }//】 Body
}

struct FilterListView_Previews: PreviewProvider {
    static var previews: some View {
        FilterListView(VM: PodongViewModel())
    }
}

