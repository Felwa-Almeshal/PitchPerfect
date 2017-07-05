//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Felwa Almeshal on 9/10/1438 AH.
//  Copyright © 1438 Felwa Almeshal. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController , AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       stopRecordingButton.isEnabled = false
    }

   

    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        print("viewWillApear called")
    }

    
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording .. "
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath)
        
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record(forDuration: 10)
        
        
    }
 
 
    @IBAction func stop(_ sender: Any) {
         recordingLabel.text = " Stop Record button was pressed"
         recordButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
        performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        }else {
            print (" Recording was not successful !")
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecordingSegue"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
    }
    }
    
}

