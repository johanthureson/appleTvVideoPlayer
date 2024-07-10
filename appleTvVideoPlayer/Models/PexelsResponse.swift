//
//  PexelsResponse.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import Foundation

struct PexelsResponse: Codable {
    let perPage: Int
    let nextPage: String?
    let videos: [Video]
    
    enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case nextPage = "next_page"
        case videos
    }
}

