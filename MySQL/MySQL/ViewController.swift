//
//  ViewController.swift
//  MySQL
//
//  Created by sujustin on 2018/4/12.
//  Copyright © 2018年 SuJustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errText: UILabel!
    
    struct User: Codable {
        var name: String
        var password: String
    }
    
    struct Response: Codable {
        var status: String
        var user: ResUser
    }
    struct ResUser: Codable {
        var name: String
        var email: String
    }
    
    struct TestJson: Codable {
        var get: String
        var post: String
        var header: TestHeader
        var file: String
    }
    struct TestHeader: Codable {
        var accept: String
        var accept_encoding: String
        var accept_language: String
        var connect: String
        var host: String
        var res: String
        var user_agent: String
    }
    
    @IBAction func submitAction(_ sender: Any) {
        guard let user = nameField.text, nameField.text != "",
            let password = passwordField.text, passwordField.text != "" else{
                errText.textColor = UIColor.red
                errText.text = "Name and Password can't empty!!!!"
                return
        }
        //JSONSerialization
        //        let user1 = ["name": "\(user)", "password": "\(password)"]
        //        guard let data = try? JSONSerialization.data(withJSONObject: user1, options: []) else{return}
        
        let testUrl = URL(string: "http://scsonic.com/debug.php")
        let url = URL(string: "http://localhost:3000")
        var request = URLRequest(url: testUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //JSON Encoder/Decoder
        do{
            let user1 = User(name: user, password: password)
            let encoder = JSONEncoder()
            let data = try encoder.encode(user1)
            request.httpBody = data
        }catch{print("[ERROR] encode error")}
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data, error == nil else {
                print("[ERROR Message]"+(error?.localizedDescription ?? "No data"))
                return
            }
            do{
                let res = try JSONDecoder().decode(Response.self, from: data)
                let text = """
                ============================
                Status: \(res.status)
                name: \(res.user.name)
                email: \(res.user.email)
                ==============================
                """
                print("\(text)")
            }catch{print("[ERROR] decode error1")}
            do{
                try print("\(JSONSerialization.jsonObject(with: data, options: []))\n...\(response)")

                let testRes = try JSONDecoder().decode(TestJson.self, from: data)
                let header = testRes.header
                let txt = """
                                ===========================
                                get/post: \(testRes.get)/\(testRes.post)
                                accept: \(header.accept)
                                accept_encoding: \(header.accept_encoding)
                                accept_language: \(header.accept_language)
                                connect: \(header.connect)
                                host: \(header.host)
                                Upgrade-Insecure-Requests: \(header.res)
                                User-Agent: \(header.user_agent)
                                ==================================
                    """
                print(txt)
            }catch{print("[ERROR] decode error2")}
        }
        task.resume()
    }
}
