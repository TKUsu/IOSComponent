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
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
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
        
        let parameters = ["fields": "first_name, last_name, gender, age_range, picture.type(large), email, languages, work, location"]

        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {
            [weak self] connection, result, error in
            if error != nil {
                print("[ERROR]: 登入失敗")
                print("[ERROR MSG]: longinerror =\(String(describing: error))")
            }else{
                let fbresult = result as! Dictionary<String, AnyObject>
                print("[SUCEESS]: 登入成功")
                print("""
                    ==================================================
                    [Data] Result: \(fbresult)
                    ==================================================
                    """)
                self?.setFBData(fbresult)
            }
        }
    }
    
    func setFBData(_ data: Dictionary<String, AnyObject>) {
        //id
        self.idLabel.text = data["id"] as! String
        //email
        if let email = data["email"]{
            print("[DATA] email: \(email)")
            self.emailTxt.text = email as! String
        }else{
            print("[ERROR]: Email isn't found")
            self.emailTxt.text = ""
        }
        //name
        let firstName = data["first_name"] as! String
        let lastName = data["last_name"] as! String
        self.nameTxt.text = firstName + lastName
        //picture
        if let picture = data["picture"] as? NSDictionary,
            let data = picture["data"] as? NSDictionary,
            let url = data["url"] as? String{
            let imgURL = NSURL(string: url)! as URL
            let imgData = NSData(contentsOf: imgURL)! as Data
            let img = UIImage(data: imgData) as! UIImage
            self.imgView.image = img
            print("[Data]: Image url = \(url)")
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
