//
//  NewsSourceCM.swift
//  LucasCordeiro
//
//  Created by Lucas Cordeiro on 16/02/19.
//  Copyright © 2019 Sparks. All rights reserved.
//

import Foundation

struct NewsSource: Codable {
    let sourceID: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case sourceID = "id"

        case name
    }
}
