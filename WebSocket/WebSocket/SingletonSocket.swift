//
//  Webscoket.swift
//  WebSocket
//
//  Created by sujustin on 2017/5/14.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import Foundation
import UIKit
import Starscream

class SingletonSocket{
    let socket: WebSocket = WebSocket(url: NSURL(string: "ws://localhost:3000")! as URL, protocols: ["room-chat"])
    
    class var sharedInstance : SingletonSocket{
        struct Static{
            static let instance: SingletonSocket = SingletonSocket()
        }
        
        if !Static.instance.socket.isConnected{
            Static.instance.socket.connect()
        }
        return Static.instance
    }
}



//原文網址：https://read01.com/J0nagd.html
