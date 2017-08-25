//
//  recordingVoice.swift
//  speechKit
//
//  Created by sujustin on 2017/8/22.
//  Copyright © 2017年 SuJustin. All rights reserved.
//

import AVFoundation
import UIKit
import Speech

protocol RecordingProtocol: class {
    func Recognition(Text: String)
}

class RecordingVoice: NSObject {
    fileprivate var speechRecognizer = SFSpeechRecognizer()
    fileprivate let audioEngine = AVAudioEngine()
    fileprivate var request: SFSpeechAudioBufferRecognitionRequest?
    fileprivate var recognitionTask: SFSpeechRecognitionTask?
    fileprivate var audioSession = AVAudioSession.sharedInstance()
    
    var isEngineFlag = false
    
    var delegate: RecordingProtocol?
    fileprivate var text: String?
    fileprivate var timer:Timer!

    override init() {
        super.init()
        if getAccount() == "user1" {
            languageTW()
        }else if getAccount() == "user2"{
            languageEN()
        }
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            var flag = false
            switch authStatus {
                case .authorized:
                    flag = true
                    
                case .denied:
                    flag = false
                    print("User denied access to speech recognition")
                    
                case .restricted:
                    flag = false
                    print("Speech recognition restricted on this device")
                    
                case .notDetermined:
                    flag = false
                    print("Speech recognition not yet authorized")
            }
            OperationQueue.main.addOperation() {
                self.isEngineFlag = flag
            }
        }
    }
    
    func start(button: UIButton) {
        if audioEngine.isRunning {
            stopRecording()
            isEngineFlag = false
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "Mute Mic"), for: .normal)
            }
        } else {
            isEngineFlag = true
            recognition()
            DispatchQueue.main.async {
                button.setImage(UIImage(named: "Mic"), for: .normal)
            }
        }
    }
    
    func recognition() {
        guard isEngineFlag else {
            return
        }
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        request = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = request else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, delegate: self)
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            print("[Running]: Time = \(when.hostTime)")
            recognitionRequest.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode?.removeTap(onBus: 0)
        self.request?.endAudio()
        self.recognitionTask = nil
        do {
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        }catch let error as NSError{
            print(error.code)
        }
        if(timer != nil){
            timer.invalidate()
            timer = nil
        }
    }
    
    func languageTW() {
        speechRecognizer = SFSpeechRecognizer(locale: .init(identifier: "zh-TW"))
    }
    func languageEN() {
        speechRecognizer = SFSpeechRecognizer(locale: .init(identifier: "en-US"))
    }
}

extension RecordingVoice: SFSpeechRecognitionTaskDelegate{
    //偵測到聲音
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didHypothesizeTranscription transcription: SFTranscription) {
        if(timer != nil && timer.isValid){
            timer.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true, block: { (Timer) in
            if (self.request != nil) {
                self.request?.endAudio()
            }
        })
    }
    //開始識別
    func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
        print("********  Speech RecognitionTask Finished Reading Audio  ********")
    }
    //識別後處理
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        text = recognitionResult.bestTranscription.formattedString
        self.delegate!.Recognition(Text: text!)
    }
    //識別結束
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        print("[Result]:  \(String(describing: text))")
        if isEngineFlag {
            stopRecording()
            recognition()
        }
    }
}

