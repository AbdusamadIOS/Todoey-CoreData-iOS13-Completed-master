//
//  AddInfoVC.swift
//  Todoey
//
//  Created by Abdusamad Mamasoliyev on 18/06/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class AddInfoVC: UIViewController {

    @IBOutlet weak var photo1: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var qarzdorlikTF: UITextField!
    @IBOutlet weak var haqdorlikTF: UITextField!
    @IBOutlet weak var boshqaTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var imageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.layer.cornerRadius = 20
        saveButton.clipsToBounds = true
        photo1.layer.cornerRadius = 20
        photo1.layer.borderColor = UIColor.gray.cgColor
        photo1.layer.borderWidth = 0.6
        photo2.layer.cornerRadius = 20
        photo2.layer.borderColor = UIColor.gray.cgColor
        photo2.layer.borderWidth = 0.6
        
    }

    @IBAction func photo1Button(_ sender: UIButton) {
        
        imageIndex = 1
    }
    
    @IBAction func photo2Button(_ sender: UIButton) {
        
        imageIndex = 2
     }
    
    @IBAction func saveButton(_ sender: UIButton) {
    }
}
