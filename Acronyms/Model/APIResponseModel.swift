//
//  APIResponseModel.swift
//  Acronyms
//
//  Created by Anusha G on 10/27/21.
//

import Foundation

struct APIResponseModel: Decodable {
    let lfs: [LF]?
}

// MARK: - LF
struct LF: Decodable {
    let lf: String
}
