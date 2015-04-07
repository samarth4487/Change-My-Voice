//
//  ViewController.swift
//  Change My Voice
//
//  Created by samarth paboowal on 4/3/15.
//  Copyright (c) 2015 samarth paboowal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
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
    }

    @IBAction func recordAudio(sender: UIButton) {
        starting.hidden = true
        recordingInProgress.hidden = false
        labelStopRecording.hidden = false
        stopRecording.hidden = false
        recordAudio.enabled = false
        
        // TODO: Record user's voice
        println("in recordAudio")
    }

    @IBAction func stopRecording(sender: AnyObject) {
        
    }
}

