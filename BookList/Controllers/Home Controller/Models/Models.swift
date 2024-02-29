//
//  Models.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import Foundation

struct ResponseData {
    let error: Error?
    let response: Data?
    
    init(error: Error? = nil, response: Data?) {
        self.error = error
        self.response = response
    }
}

// MARK: - AuthorDataModel
struct AuthorDataModel: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
