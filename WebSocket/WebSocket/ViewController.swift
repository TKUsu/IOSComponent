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
    
    @IBOutlet weak var text: UILabel!
    let socket = SingletonSocket.sharedInstance.socket
    let socket2 = testConnect.sharedInstance.socket
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func connectAction(_ sender: UIButton) {
        socket.delegate = self
        socket.write(string: "hello world")
        
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        socket.write(string: txetField.text!) {
            print("***Message was send***")
        }
        
        let temp = ["email":"peter@gmail.com", "password":"123", "time":"12:00"]
        socket2.write(data: temp as! Data) {
            print("***Message send: \(temp)")
        }
    }
    
    @IBAction func peerConnectAction(_ sender: UIButton) {
        socket2.delegate = self
    }
    
    @IBAction func disConnectAction(_ sender: UIButton) {
        socket.disconnect()
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
