//
//  ViewController.swift
//  fingerprint-ios
//
//  Created by Donnie Mattingly on 2/28/18.
//  Copyright © 2018 Donnie Mattingly. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var allowedToRecord = false
    var recording = false
    var recordingUrl: String?
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rustGreetings = RustGreetings()
//        print("\(rustGreetings.sayHello(to: " world"))")
        rustGreetings.calculateHashes();
        // Do any additional setup after loading the view, typically from a nib.
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    self.allowedToRecord = allowed
                }
            }
        } catch {
            // failed to record!
            print("Error recording")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRecording() {
        self.recording = true
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.wav")
        self.recordingUrl = audioFilename.absoluteString
        
        let rustGreetings = RustGreetings()
        print("\(rustGreetings.sayHello(to: audioFilename.absoluteString))")
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatLinearPCM),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//            recordButton.setTitle("Tap to Stop", for: .normal)
//        } catch {
//            print(error)
////            finishRecording(success: false)
//        }
    }
    
    @IBAction func recordPressed(_ sender: UIButton) {
        print("Button presssed")
        
//        if !recording {
//            startRecording()
//        } else {
//            finishRecording(success: true)
//        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        self.recording = false;
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }


}

