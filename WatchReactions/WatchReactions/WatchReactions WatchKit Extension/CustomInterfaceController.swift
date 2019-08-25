//
//  CustomInterfaceController.swift
//  WatchReactions WatchKit Extension
//
//  Created by RAJ RAVAL on 25/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import WatchKit
import AVFoundation


class CustomInterfaceController: WKInterfaceController {
    
    let saveURL = FileManager.default.getDocumentsDirectory().appendingPathComponent("recording.wav")
    
    var audioPlayer: AVAudioPlayer?

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func recordTapped() {
        presentAudioRecorderController(withOutputURL: saveURL, preset: .narrowBandSpeech) {
            success, error in
            if success {
                print("Saved Successfully")
            } else {
                print(error?.localizedDescription ?? "Unknown Error")
            }
        }
    }
    
    
    @IBAction func playTapped() {
        guard FileManager.default.fileExists(atPath: saveURL.path) else { return }
        
        try? audioPlayer = AVAudioPlayer(contentsOf: saveURL)
        audioPlayer?.play()
    }
    
}
