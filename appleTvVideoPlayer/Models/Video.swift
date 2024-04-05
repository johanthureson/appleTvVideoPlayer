//
//  Video.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-05.
//

import Foundation

struct Video: Identifiable, Decodable {
    let id: String
    let title: String
    let language: String
}
