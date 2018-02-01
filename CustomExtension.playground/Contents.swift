//  Custom Extension
//  Created by sujustin on 2018/02/01.
//  Copyright © 2017年 SuJustin. All rights reserved.
//

import UIKit
extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
}
//View Style & Custom Color Background
extension UIView{
    func setSenseFoxColor() {
        var gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.init(rgb: 0x6a60ee).cgColor, UIColor.init(rgb: 0x56edff).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setSenseFoxColorSub() {
        var gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.init(rgb: 0x6a60ee).cgColor, UIColor.init(rgb: 0x56edff).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        gradientLayer.cornerRadius = 25
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func shadowStyle(width: CGFloat = 3, height: CGFloat = 2, color: UIColor = UIColor.black) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.init(width: width, height: height)
        self.clipsToBounds = false
    }
}
//Edit style
extension UITextField{
    func senseFoxStyle() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }
}
//Label
extension UILabel{
    func wordwrapping() {
        self.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.numberOfLines = 0
    }
}
//Table style
extension UITableView{
    func senseFoxStyle() {
        let hight = UIScreen.main.bounds.height
        self.separatorStyle = .none
        self.rowHeight = hight / 9
    }
}
//Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
//Int


