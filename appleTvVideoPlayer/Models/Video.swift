//
//  Video.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import Foundation

struct Video: Codable, Identifiable {
    let id: Int
    let url: String
    let image: String
    let videoFiles: [VideoFile]
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case image
        case videoFiles = "video_files"
    }
}
