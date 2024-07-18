//
//  VideoGridView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import SwiftUI

struct VideoGridView: View {
    
    var viewModel: VideoViewModel
    let width = CGFloat(310)
    @State private var selectedVideo: Video? = nil
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: width))], spacing: 20) {
                    ForEach(viewModel.videos) { video in
                        Button(action: {
                            selectedVideo = video
                        }) {
                            VStack {
                                AsyncImage(url: URL(string: video.image)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: width, height: width / 16 * 9)
                                        .cornerRadius(10)
                                        .clipped()
                                } placeholder: {
                                    ProgressView()
                                }
                                Text(VideoGridView.videoTitle(from: video.url))
                                    .font(.caption)
                            }
                        }
                        .buttonStyle(PlainNavigationLinkButtonStyle())
                        .task {
                            if video.url == viewModel.videos.last?.url {
                                await viewModel.fetchVideos(urlString: viewModel.nextPage)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Videos")
        }
        .fullScreenCover(item: $selectedVideo) { video in
            VideoPlayerView(video: video)
        }
        .task {
            await viewModel.fetchVideos()
        }
    }
    
    static func videoTitle(from url: String) -> String {
        let components = url.split(separator: "/")
        return components.last.map(String.init) ?? "Unknown"
    }

}
