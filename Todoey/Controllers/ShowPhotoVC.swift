//
//  ShowPhotoVC.swift
//  Todoey
//
//  Created by Abdusamad Mamasoliyev on 21/06/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class ShowPhotoVC: UIViewController {

    @IBOutlet weak var showPhoto: UIImageView!
    
    var photo1 = UIImage(named: "shop")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showPhoto.image = photo1
        
    }

}
