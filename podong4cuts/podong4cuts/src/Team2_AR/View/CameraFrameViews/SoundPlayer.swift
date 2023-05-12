//
//  SoundPlayer.swift
//  podong4cuts
//
//  Created by 이승용 on 2023/05/12.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    static var soundPlayer  = SoundPlayer()
    var player: AVAudioPlayer?
    
    mutating func play(fileName: String) {
//        print("Ready to play sound")
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("\(fileName) not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Cannot play sound")
        }
        
        
    }
    
}
