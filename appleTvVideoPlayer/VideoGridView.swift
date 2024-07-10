//
//  VideoGridView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import SwiftUI

struct VideoGridView: View {
    @State private var viewModel = VideoViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))], spacing: 20) {
                    ForEach(viewModel.videos) { video in
                        NavigationLink(destination: VideoPlayerView(video: video)) {
                            VStack {
                                AsyncImage(url: URL(string: video.image)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 150, height: 150)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(VideoGridView.videoTitle(from: video.url))
                                    .font(.caption)
                                    .lineLimit(1)
                            }
                        }
                        .onAppear {
                            if video.url == viewModel.videos.last?.url {
                                viewModel.fetchVideos(urlString: viewModel.nextPage)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Videos")
        }
    }
    
    static func videoTitle(from url: String) -> String {
        let components = url.split(separator: "/")
        return components.last.map(String.init) ?? "Unknown"
    }
}
