//
//  NewsCM.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation

struct NewsResult: Codable {
    let status: String?
    let totalResults: Int?
    let code: String?
    let message: String?
    let articles: [News]?
}

struct News: Codable {
    let title: String?
    let newsDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: NewsSource?

    enum CodingKeys: String, CodingKey {
        case newsDescription = "description"

        case title
        case url
        case urlToImage
        case publishedAt
        case content
        case source
    }
}
