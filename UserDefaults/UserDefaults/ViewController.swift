//
//  ViewController.swift
//  UserDefaults
//
//  Created by sujustin on 2018/2/1.
//  Copyright © 2018年 SuJustin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var keyField: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    
    private var userDefaults: UserDefaults!
    private var keys: Array = [""]
    private var values: Array = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults = UserDefaults.standard
        table.separatorStyle = .none
        sync()
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func updateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let keyText = keyField.text else {
            keyField.textColor = UIColor.red
            keyField.placeholder = "Empty"
            return
        }
        userDefaults.set(textField.text, forKey: keyText)
        userDefaults.synchronize()
        sync()
    }
    @IBAction func deleteAction(_ sender: UIButton) {
        guard let keyText = keyField.text else {
            keyField.textColor = UIColor.red
            keyField.placeholder = "Empty"
            return
        }
        userDefaults.removeObject(forKey: keyText)
        sync()
    }
    
    func sync() {
        keys = [""]
        values = [""]
        for (key, value) in userDefaults.dictionaryRepresentation() {
            keys.append("\(key)")
            values.append("\(value)")
            print("\(key) = \(value) \n")
        }
        table.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.keyLabel.text = keys[indexPath.row]
        cell.valueLabel.text = values[indexPath.row]
        cell.keyLabel.lineBreakMode = .byWordWrapping
        cell.keyLabel.numberOfLines = 0
        return cell
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


