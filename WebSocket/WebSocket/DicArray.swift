//
//  DicArray.swift
//  WebSocket
//
//  Created by sujustin on 2017/7/19.
//  Copyright © 2017年 sujustin. All rights reserved.
//

import Foundation

//Import: https://gist.github.com/mosluce/4b41cd7f601943558be0800230aa17d1#file-da-swift-L41
//By: 默司 MOS
extension Dictionary {
    subscript(string key: Key) -> String? {
        return self[key] as? String ?? nil
    }
    
    subscript(bool key: Key) -> Bool? {
        return self[key] as? Bool ?? nil
    }
    
    subscript(float key: Key) -> Float? {
        return self[key] as? Float ?? nil
    }
    
    subscript(double key: Key) -> Double? {
        return self[key] as? Double ?? nil
    }
    
    subscript(int key: Key) -> Int? {
        return self[key] as? Int ?? nil
    }
    
    subscript(array key: Key) -> Array<Any>? {
        return self[key] as? Array<Any> ?? nil
    }
    
    subscript(dictionary key: Key) -> Dictionary<AnyHashable, Any>? {
        return self[key] as? Dictionary ?? nil
    }
}

extension Array {
    subscript(string key: Index) -> String? {
        return self[key] as? String ?? nil
    }
    
    subscript(bool key: Index) -> Bool? {
        return self[key] as? Bool ?? nil
    }
    
    subscript(float key: Index) -> Float? {
        return self[key] as? Float ?? nil
    }
    
    subscript(double key: Index) -> Double? {
        return self[key] as? Double ?? nil
    }
    
    subscript(int key: Index) -> Int? {
        return self[key] as? Int ?? nil
    }
    
    subscript(array key: Index) -> Array<Any>? {
        return self[key] as? Array<Any> ?? nil
    }
    
    subscript(dictionary key: Index) -> Dictionary<AnyHashable, Any>? {
        return self[key] as? Dictionary ?? nil
    }
}
