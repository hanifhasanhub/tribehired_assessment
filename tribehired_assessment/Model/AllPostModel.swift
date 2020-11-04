//
//  AllPostModel.swift
//  tribehired_assessment
//
//  Created by Muhammad Hanif Bin Hasan on 04/11/2020.
//  Copyright © 2020 makro baru. All rights reserved.
//

import Foundation

var listAllPost = [AllPost]()
// MARK: - AllPost
struct AllPost: Codable {
    let userId, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userId 
        case id, title, body
    }
}
