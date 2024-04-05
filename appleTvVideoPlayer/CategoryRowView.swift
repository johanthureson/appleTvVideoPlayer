//
//  CategoryRowView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-05.
//

import SwiftUI

struct CategoryRow: View {
    
    var videos: [Video]

    var body: some View {
        
        VStack {
            
            HStack {
                Text("News")
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(videos, id: \.id) { video in
                        NavigationLink(destination: VideoPlayerView(videos: videos)) {
                            VStack {
                                RemoteImage(url: "https://api.dailymotion.com/video/\(video.id)?fields=thumbnail_url")
                                    .frame(maxWidth: 460)
                                    .cornerRadius(10)
                                Text(video.title)
                                    .lineLimit(2)
                                    .frame(maxWidth: 428)
                                Spacer()
                            }
                        }
                        .buttonStyle(PlainNavigationLinkButtonStyle())
                    }
                }
            }
        }
    }
}
