//
//  VideoPlayerView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-05.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    var videos: [Video]
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
        player = AVPlayer(playerItem: AVPlayerItem(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!))
        player?.play()
    }
    
}
