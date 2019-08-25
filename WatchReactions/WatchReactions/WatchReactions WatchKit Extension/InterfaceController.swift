//
//  InterfaceController.swift
//  WatchReactions WatchKit Extension
//
//  Created by RAJ RAVAL on 25/08/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import WatchKit
import AVFoundation


class InterfaceController: WKInterfaceController, SoundPlaying {
    
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
    
    
    @IBAction func playSound1() {
        playSound(named: "Sa")
    }
    
    
    @IBAction func playSound2() {
        playSound(named: "Re")
    }
    
    
    @IBAction func playSound3() {
        playSound(named: "Ga")
    }
    
    
    @IBAction func playSound4() {
        playSound(named: "Ma")
    }
    
}
