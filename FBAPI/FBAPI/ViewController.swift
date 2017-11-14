//
//  ViewController.swift
//  FBAPI
//
//  Created by sujustin on 2017/11/11.
//  Copyright © 2017年 SuJustin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    @IBOutlet weak var fbloginButton: FBSDKLoginButton!
    
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var customButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fbloginButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbloginButton.delegate = self
        print("[TEST MSG]: FB login Behavior\(fbloginButton.loginBehavior)")
        
        if (FBSDKAccessToken.current()) != nil {
            customButton.setTitle("Log Out", for: .normal)
            fetchProfile()
        }else{
            customButton.setTitle("Log In", for: .normal)
        }
    }
    
    @IBAction func FBLogOutAction(_ sender: UIButton) {
        if (FBSDKAccessToken.current()) != nil {
            customButton.setTitle("Log Out", for: .normal)
            FBSDKLoginManager().logOut()
        }else{
            customButton.setTitle("Log In", for: .normal)
            FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
                if error != nil{
                    print("longinerror =\(error)")
                    return
                }
                self.fetchProfile()
            }
        }
    }
    
    func fetchProfile(){
        print("[GET]: FB Detail")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]

        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {
            [weak self] connection, result, error in
            if error != nil {
                print("[ERROR]: 登入失敗")
                print("[ERROR MSG]: longinerror =\(String(describing: error))")
            }else{
                let fbresult = result as! Dictionary<String, AnyObject>
                print("[SUCEESS]: 登入成功")
                print("[Data] Result: \(fbresult)")
                
                if let email = fbresult["email"]{
                    print("[MAG EMAIL]: \(email)")
                    self?.emailTxt.text = email as! String
                }else{
                    print("[ERROR]: Email isn't found")
                    self?.emailTxt.text = ""
                }
                
                let firstName = fbresult["first_name"] as! String
                let lastName = fbresult["last_name"] as! String
                
                self?.nameTxt.text = firstName + lastName

                if let picture = fbresult["picture"] as? NSDictionary,
                    let data = picture["data"] as? NSDictionary,
                        let url = data["url"] as? String{
                    let imgURL = NSURL(string: url) as! URL
                    let imgData = NSData(contentsOf: imgURL) as! Data
                    let img = UIImage(data: imgData) as! UIImage
                    self?.imgView.image = img
                    print("[Data]: Image url = \(url)")
                }
            }
        }
    }
}

extension ViewController: FBSDKLoginButtonDelegate{
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        fetchProfile()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        self.imgView.image = nil
        self.emailTxt.text = ""
        self.nameTxt.text = ""
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
}
