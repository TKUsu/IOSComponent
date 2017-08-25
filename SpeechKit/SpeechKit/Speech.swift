//
//  speech.swift
//  speechTotext
//
//  Created by sujustin on 2017/8/22.
//  Copyright © 2017年 Hayes. All rights reserved.
//

import Foundation
import AVFoundation

class Speech: NSObject{
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    
    override init() {
        super.init()
        if getAccount() == "user1" {
            languageTW()
        }else if getAccount() == "user2"{
            languageEN()
        }
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do{
                try AVAudioSession.sharedInstance().setActive(true)
            }catch{}
        }catch{}
    }
    
    func talk(text: String) {
        myUtterance = AVSpeechUtterance(string: text)
        synth.speak(myUtterance)
    }
    
    func setting(rate: Float, pich: Float, delay: TimeInterval, volume: Float) {
        myUtterance.rate = rate
        myUtterance.pitchMultiplier = pich
        myUtterance.postUtteranceDelay = delay
        myUtterance.volume = volume
    }
    
    func languageTW() {
        myUtterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
    }
    func languageEN() {
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
}
