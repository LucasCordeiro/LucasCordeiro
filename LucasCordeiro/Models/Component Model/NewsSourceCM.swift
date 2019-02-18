//
//  NewsSourceCM.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation

struct NewsSourceResult: Codable {
    let status: String?
    let sources: [NewsSource]?
    let code: String?
    let message: String?
}

struct NewsSource: Codable {
    let sourceID: String?
    let name: String?
    let sourceDescription: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "id"
        case sourceDescription = "description"

        case name
        case url
        case category
        case language
        case country
    }
}
