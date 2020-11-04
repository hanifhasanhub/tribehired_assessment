//
//  CommentModel.swift
//  tribehired_assessment
//
//  Created by Muhammad Hanif Bin Hasan on 04/11/2020.
//  Copyright © 2020 makro baru. All rights reserved.
//

import Foundation

var listCommentPost = [CommentPost]()
var tmpListCommentPost = [CommentPost]()

// MARK: - CommentPost
struct CommentPost: Codable {
    let postId, id: Int?
    var name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postId
        case id, name, email, body
    }
}
