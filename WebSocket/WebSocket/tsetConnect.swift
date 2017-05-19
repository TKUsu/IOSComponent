//
//  tsetConnect.swift
//  WebSocket
//
//  Created by sujustin on 2017/5/15.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import Foundation
import UIKit
import Starscream

class testConnect{
    let socket: WebSocket = WebSocket(url: NSURL(string: "http://localhost:3000/")! as URL, protocols: ["test"])
    
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
