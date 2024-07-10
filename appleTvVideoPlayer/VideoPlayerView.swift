//
//  VideoPlayerView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-05.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    let video: Video
    
    var body: some View {
        if let highestResolutionLink = highestResolutionVideoLink(from: video.videoFiles),
           let url = URL(string: highestResolutionLink) {
            VideoPlayer(player: AVPlayer(url: url))
                .edgesIgnoringSafeArea(.all)
                .navigationTitle(videoTitle(from: video.url))
        } else {
            Text("No video available")
        }
    }
    
    private func highestResolutionVideoLink(from videoFiles: [VideoFile]) -> String? {
        videoFiles.sorted { $0.height > $1.height }.first?.link
    }
    
    private func videoTitle(from url: String) -> String {
        let components = url.split(separator: "/")
        return components.last.map(String.init) ?? "Unknown"
    }
}

