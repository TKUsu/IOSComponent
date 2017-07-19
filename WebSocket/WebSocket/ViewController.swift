//
//  ViewController.swift
//  WebSocket
//
//  Created by sujustin on 2017/5/14.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import UIKit
import Starscream

class ViewController: UIViewController {

    @IBOutlet weak var txetField: UITextField!
    
    @IBOutlet weak var text: UILabel!
    let socket = SingletonSocket.sharedInstance.socket
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set this if you are planning on using the socket in a VOIP background setting (using the background VOIP service).
        socket.voipEnabled = true
    }
    
    deinit {
        socket.disconnect()
        socket.delegate = nil
    }
    
    @IBAction func connectAction(_ sender: UIButton) {
        if socket.isConnected {
            socket.disconnect()
        }
        socket.delegate = self
        socket.connect()
        socket.write(string: "hello world")
        
        /************** option ****************
         //change headers
         socket.headers["room-caht"] = "room"
         //Bool
         socket.isConnected
        
        */
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        socket.write(string: txetField.text!) {
            print("***Message was send***")
        }
    }
    
    let sendJSON: Dictionary<String,Any> = ["email":"peter@gmail.com", "password":"123", "time":"12:00"]
    
    @IBAction func snedJsonwithStringAction(_ sender: UIButton) {
        guard JSONSerialization.isValidJSONObject(sendJSON) else {
            return
        }
        do {
            let sendData = try JSONSerialization.data(withJSONObject: sendJSON, options: [])
            //Encode: UTF8
            let sendString = String(data: sendData, encoding: String.Encoding.utf8)
            socket.write(string: sendString!)
        } catch let error {
            print("[ERROR_JsonToString]: \(error)")
        }
    }
    
    //Data\Binary
    @IBAction func sendJsonAction(_ sender: UIButton) {
        guard JSONSerialization.isValidJSONObject(sendJSON) else {
            print("[ERROR] {\(sendJSON)} isn't can a vaild json object")
            return
        }
        do{
            let sendDATA = try JSONSerialization.data(withJSONObject: sendJSON, options: [])
            socket.write(data: sendDATA) {
                print("***  Message send: \(sendDATA)   ***")
            }
        } catch let error {
            print("[ERROR]: \(error)")
        }
    }
    
    @IBAction func disConnectAction(_ sender: UIButton) {
        socket.disconnect()
    }
}

extension ViewController: WebSocketDelegate{
    func websocketDidConnect(socket: WebSocket) {
        print("Did Connect.......")
//        socket.write(string: username)
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("Did Disconnect!!!!!!!! [\(error)]")
        //加入當伺服器斷開後跳回畫面的例外處理
        //        performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("Server Receive Data: \(data)")
        let json = deCodeDataToJson(data)
        if let messageType = json[0][string: "email"],messageType == "peter@gmail.com" {
            print("\(messageType)")
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("Server Receive Message: \(text)")
        let _ = deCodeStringToJson(text)
    }
}

extension ViewController{
    func deCodeDataToJson(_ data: Data) -> [Dictionary<String, Any>]{
        var json: [Dictionary<String, Any>] = []
        
        guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
            let jsonDict = jsonData as? [String: Any] else {
            return []
        }
        json.append(jsonDict)
        
        return json
    }
    
    func deCodeStringToJson(_ text: String) -> [Dictionary<String, Any>] {
        var json: [Dictionary<String, Any>] = []
        
        guard let data = text.data(using: .utf16),
            let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
                let jsonDict = jsonData as? [String: Any],
                    let messageType = jsonDict["type"] as? String else {
            return []
        }
        if messageType == "message",
            let messageData = jsonDict["data"] as? [String: Any],
            let messageAuthor = messageData["author"] as? String,
            let messageText = messageData["text"] as? String {
        }
        
        json.append(jsonDict)
        
        return json
    }
    /*
     {
        "type": "message",
        "data":
        {
            "time": 1472513071731, "text": ":]", "author": "iPhone Simulator", "color": "orange"
        }
     }
     */
}
