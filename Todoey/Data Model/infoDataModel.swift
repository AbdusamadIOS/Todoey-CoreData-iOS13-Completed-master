//
//  infoDataModel.swift
//  Todoey
//
//  Created by Abdusamad Mamasoliyev on 20/06/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation

struct Info: Codable {
    var qarzdorligi: String
    var haqdorligi: String
    var boshqa: String
    var date: String
    var photo1: Data
    var photo2: Data
}
