//
//  LoginVC.swift
//  Todoey
//
//  Created by Abdusamad Mamasoliyev on 20/06/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.layer.cornerRadius = 16
        nextBtn.clipsToBounds = true
        phoneNumberTF.delegate = self
        passwordTF.delegate = self
    }

    @IBAction func nextBtn(_ sender: UIButton) {
        if phoneNumberTF.text == "+998" && passwordTF.text == "" {
            performSegue(withIdentifier: "goToMain", sender: self)
        } else {
            phoneNumberTF.layer.borderColor = UIColor.red.cgColor
            phoneNumberTF.layer.borderWidth = 0.8
            passwordTF.layer.borderColor = UIColor.red.cgColor
            passwordTF.layer.borderWidth = 0.8
        }
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
