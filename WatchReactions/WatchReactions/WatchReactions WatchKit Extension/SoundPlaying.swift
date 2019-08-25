//
//  SoundPlaying.swift
//  WatchReactions WatchKit Extension
//
//  Created by RAJ RAVAL on 25/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import AVFoundation

protocol SoundPlaying: AnyObject {
    var audioPlayer: AVAudioPlayer? { get set }
}

extension SoundPlaying {
    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
            fatalError("Unable to find sound file \(name).wav")
        }
        
        try? audioPlayer = AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
}
