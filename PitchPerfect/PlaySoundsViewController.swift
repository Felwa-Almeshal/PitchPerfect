//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Felwa Almeshal on 9/12/1438 AH.
//  Copyright © 1438 Felwa Almeshal. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundsViewController: UIViewController {
    var recordedAudioURL :URL!
    
    @IBOutlet weak var snailButton : UIButton!
    @IBOutlet weak var chipmunkButton : UIButton!
    @IBOutlet weak var rabbitButton : UIButton!
    @IBOutlet weak var vaderButton : UIButton!
    @IBOutlet weak var echoButton : UIButton!
    @IBOutlet weak var reverButton : UIButton!
    @IBOutlet weak var stopButton : UIButton!
    
    
    var _recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
  //var audioPlayer: AVAudioPlayer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        
        
    }
   

   // var numberOfLoops: Int { numberOfLoops =  1 }
 
    @IBAction func playSoundForButton(_ sender: UIButton) {
      
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
          
                playSound(rate: 0.5)
   
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
        
        
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
     stopAudio()
    }

    
    override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
}
