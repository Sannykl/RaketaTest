//
//  PostModel.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

struct PostModel: Codable {
    let data: PostData
}

struct PostData: Codable {
    let title: String
    let author: String
    let createdAt: Int
    let thumbnail: String
    let commentsCount: Int
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case author
        case createdAt = "created_utc"
        case thumbnail
        case commentsCount = "num_comments"
        case imageURL = "url"
    }
}
