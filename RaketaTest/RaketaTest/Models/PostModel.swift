//
//  PostModel.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

struct PostModel: Codable {
    let title: String
    let author: String
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "data"
        case author = "data"
        case createdAt = "data"
    }
}
