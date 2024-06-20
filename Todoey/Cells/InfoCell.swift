//
//  InfoCell.swift
//  Todoey
//
//  Created by Abdusamad Mamasoliyev on 18/06/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class InfoCell: UITableViewCell {

    static let identifeir = "InfoCell"
    
    @IBOutlet weak var photo1: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var qarzdorlikLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
//        photo1.layer.cornerRadius = 10
//        photo1.layer.borderColor = UIColor.lightGray.cgColor
//        photo1.layer.borderWidth = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        photo1.layer.cornerRadius = 10
        photo1.layer.borderColor = UIColor.lightGray.cgColor
        photo1.layer.borderWidth = 0.6
    }
    
}
