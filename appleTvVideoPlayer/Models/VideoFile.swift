//
//  VideoFile.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import Foundation

struct VideoFile: Codable {
    let height: Int
    let width: Int
    let link: String
    let quality: String
}
