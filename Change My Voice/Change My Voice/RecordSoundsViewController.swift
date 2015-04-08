//
//  RecordSoundsViewController.swift
//  Change My Voice
//
//  Created by samarth paboowal on 4/3/15.
//  Copyright (c) 2015 samarth paboowal. All rights reserved.
//

import UIKit
import AVFoundation

var audioRecorder: AVAudioRecorder!
var recordedAudio: RecordedAudio!

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    
    @IBOutlet weak var starting: UILabel!
    
    @IBOutlet weak var recordAudio: UIButton!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var stopRecording: UIButton!
    
    @IBOutlet weak var labelStopRecording: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        // Hide the stop button initially
        stopRecording.hidden = true
        recordAudio.enabled = true
        recordingInProgress.hidden = true
        labelStopRecording.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        starting.hidden = true
        recordingInProgress.hidden = false
        labelStopRecording.hidden = false
        stopRecording.hidden = false
        recordAudio.enabled = false
        
        // TODO: Record user's voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag){
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
            self.performSegueWithIdentifier("stoprecording", sender: recordedAudio)
        }
        
        else{
            println("Recording was not successfull")
            recordAudio.enabled = true
            stopRecording.hidden = true
            starting.hidden = false
            recordingInProgress.hidden = true
            labelStopRecording.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stoprecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            playSoundsVC.recievedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: AnyObject) {
        recordingInProgress.hidden = true
        labelStopRecording.hidden = true
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)    }
}

