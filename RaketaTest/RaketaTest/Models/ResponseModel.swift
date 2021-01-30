//
//  ResponseModel.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

struct ResponseModel: Codable {
    let data: ResponseData
}

struct ResponseData: Codable {
    let children: [PostModel]
    let after: String?
}
