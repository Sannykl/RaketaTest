//
//  RespnseError.swift
//  RaketaTest
//
//  Created by mac on 28.01.2021.
//

import Foundation

enum ResponseError: Error {
    case parsing(description: String)
    case network(description: String)
}
