//
//  ViewController.swift
//  WebSocket
//
//  Created by sujustin on 2017/5/14.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController, WebSocketDelegate {

    @IBOutlet weak var txetField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func connectAction(_ sender: UIButton) {
        SingletonSocket.sharedInstance.socket.delegate = self
        SingletonSocket.sharedInstance.socket.connect()
        SingletonSocket.sharedInstance.socket.write(string: "hello world")
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        SingletonSocket.sharedInstance.socket.write(string: txetField.text!) { 
            print("***Message was send***")
        }
    }
    
    @IBAction func disConnectAction(_ sender: UIButton) {
        SingletonSocket.sharedInstance.socket.disconnect()
    }
    
    func websocketDidConnect(socket: WebSocket) {
        print("Did Connect.......")
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("Did Receive Data: \(data.count)")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("Did Disconnect!!!!!!!! [\(error)]")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        
        print("Receive Message: \(text)")
    }
}
