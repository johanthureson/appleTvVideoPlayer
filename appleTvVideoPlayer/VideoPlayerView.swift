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
    @State var player: AVPlayer?
    
    var body: some View {
        VStack {
            VideoPlayer(player: player)
                .onAppear {
                    setPlayer()
                }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private func setPlayer() {
        if let highestResolutionLink = highestResolutionVideoLink(from: video.videoFiles),
           let url = URL(string: highestResolutionLink) {
            player = AVPlayer(playerItem: AVPlayerItem(url: url))
            player?.play()
        }
    }
    
    private func highestResolutionVideoLink(from videoFiles: [VideoFile]) -> String? {
        videoFiles.sorted { $0.height > $1.height }.first?.link
    }
    
}
