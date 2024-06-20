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
    
    var closure:((Info) -> Void)?
    var imageIndex = 0
    var selectedImage = UIImage(named: "shop")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setting()
    }
    
    func setting() {
        saveButton.layer.cornerRadius = 20
        saveButton.clipsToBounds = true
        photo1.layer.cornerRadius = 20
        photo1.layer.borderColor = UIColor.gray.cgColor
        photo1.layer.borderWidth = 0.6
        photo2.layer.cornerRadius = 20
        photo2.layer.borderColor = UIColor.gray.cgColor
        photo2.layer.borderWidth = 0.6
        qarzdorlikTF.keyboardType = .numberPad
        haqdorlikTF.keyboardType = .numberPad
        
        qarzdorlikTF.delegate = self
        haqdorlikTF.delegate = self
        boshqaTF.delegate = self
    }

    @IBAction func photo1Button(_ sender: UIButton) {
        
        imageIndex = 1
        uploadPhoto()
    }
    
    @IBAction func photo2Button(_ sender: UIButton) {
        
        imageIndex = 2
        uploadPhoto()
     }
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        print(dateString)
                
        let task = Info(qarzdorligi: qarzdorlikTF.text ?? "",
                        haqdorligi: haqdorlikTF.text ?? "",
                        boshqa: boshqaTF.text ?? "",
                        date: dateString,
                        photo1: (selectedImage?.pngData())!,
                        photo2: (selectedImage?.pngData())!)
        print(dateString)
        if let closure {
            closure(task)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func uploadPhoto() {
        let alert = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .alert)
        
        let camera = UIAlertAction(title: "Camera", style: .default ) { _ in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true)
                
            }else{
                
                let alert = UIAlertController(title: "Camera is not available on this device", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "cancel", style: .destructive)
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
        
        let gallery = UIAlertAction(title: "Gallery", style: .default) { _ in
            
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(camera)
        alert.addAction(gallery)
        alert.addAction(cancel)
        self.present( alert, animated: true)
    }
}

extension AddInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if imageIndex == 1 {
            let image1 = info[.editedImage] as! UIImage
            selectedImage = image1
            photo1.image = image1
        } else if imageIndex == 2 {
            let image2 = info[.editedImage] as! UIImage
            selectedImage = image2
            photo2.image = image2
            
        }
        dismiss(animated: true)
    }
}

extension AddInfoVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
