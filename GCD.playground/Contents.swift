//: Playground - noun: a place where people can play

import UIKit

func simpleGCD() {
    let queue = DispatchQueue(label: "queue")
    let queue2 = DispatchQueue(label: "queue2")
    
    queue.async {
        for i1 in 0..<10{
            print("😀", i1)
        }
    }
    
    queue.async {
        for i2 in 0..<10{
            print("😈", i2)
        }
    }
    
    queue2.async {
        for i3 in 0..<10{
            print("😡", i3)
        }
    }
    
    for i4 in 0..<10{
        print("☠️", i4)
    }
}

//qos（優先權限）:UserInterActive > UserInitiated > Default > Utility > Background > Unspecified
func qosGCD() {
    let queueInterActive = DispatchQueue(label: "queue.InterActive", qos: .userInteractive)
    let queueInit = DispatchQueue(label: "queue.Init", qos: .userInitiated)
    let queueDefault = DispatchQueue(label: "queue.Default", qos: .default)
    let queueUtility = DispatchQueue(label: "queue.Utility", qos: .utility)
    let queueBackground = DispatchQueue(label: "queue.Background", qos: .background)
    let queueUnspecified = DispatchQueue(label: "queue.Unspecified", qos: .unspecified)
    
//    queueInit.async {
//        for j1 in 0..<5{
//            print("User Initiated👉🏼", j1)
//        }
//    }
//    queueDefault.async {
//        for j2 in 0..<5{
//            print("Default👇🏽", j2)
//        }
//    }
//    queueUtility.async {
//        for j3 in 0..<5{
//            print("Utility👈", j3)
//        }
//    }
    queueBackground.async {
        for j4 in 0..<5{
            print("Backgroung💀", j4)
        }
    }
//    queueUnspecified.async {
//        for j5 in 0..<5{
//            print("Unspecified💩", j5)
//        }
//    }
    queueInterActive.async {
        for j6 in 0..<5{
            print("User Interactive👆", j6)
        }
    }
    
    for j7 in 0..<5{
        print("☠️", j7)
    }
}



//simpleGCD()
//qosGCD()
