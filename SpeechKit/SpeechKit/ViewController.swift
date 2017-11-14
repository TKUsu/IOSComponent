//
//  ViewController.swift
//  SpeechKit
//
//  Created by sujustin on 2017/8/22.
//  Copyright © 2017年 SuJustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    private var speeching = false
    
    let recording = RecordingVoice()
    let mySpeech = Speech()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Speech To Text
        recording.delegate = self
        
        //Setting Language
        mySpeech.languageTW()
        recording.languageTW()
    }

    @IBAction func speechAction(_ sender: UIButton) {
        if speeching {
            speeching = false
            speechButton.setTitle("Start Speech", for: .normal)
            mySpeech.talk(text: textLabel.text as! String)
        }else{
            speeching = true
            speechButton.setTitle("Stop Speech", for: .normal)
        }
        recording.start()
    }
}

extension ViewController: RecordingProtocol{
    func Recognition(Text: String) {
        textLabel.text = Text
    }
}
