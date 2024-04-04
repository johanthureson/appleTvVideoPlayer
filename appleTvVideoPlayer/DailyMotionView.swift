//
//  DailyMotionView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-04.
//

import SwiftUI
import AVKit

struct Video: Identifiable, Decodable {
    let id: String
    let title: String
    let language: String
}

struct VideoList: Decodable {
    let list: [Video]
}

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

struct DailyMotionView: View {
    @State private var videos: [Video] = []

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CategoryRow(videos: videos)
                CategoryRow(videos: videos)
                CategoryRow(videos: videos)
                CategoryRow(videos: videos)
            }.onAppear(perform: fetchVideos)
        }
    }

    func fetchVideos() {
        guard let url = URL(string: "https://api.dailymotion.com/videos?fields=id,title,language&channel=news&limit=10&family_filter=true&localization=en") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(VideoList.self, from: data) {
                    DispatchQueue.main.async {
                        self.videos = decodedResponse.list
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct Thumbnail: Decodable {
    let thumbnail_url: String
}

struct RemoteImage: View {
    let url: String
    @State private var data: Data = Data()

    var body: some View {
        Image(uiImage: UIImage(data: data) ?? UIImage())
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fill)
            .frame(width: 450, height: 255)
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 5)
            .onAppear(perform: fetchThumbnailURL)
    }

    func fetchThumbnailURL() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Thumbnail.self, from: data) {
                    fetchImage(from: decodedResponse.thumbnail_url)
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }

    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }.resume()
    }
}

struct PlainNavigationLinkButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    PlainNavigationLinkButton(configuration: configuration)
  }
}

struct PlainNavigationLinkButton: View {
  
  @Environment(\.isFocused) var focused: Bool
    @State private var isWobbling: Bool = false

  let configuration: ButtonStyle.Configuration

  var body: some View {
    configuration.label
          .aspectRatio(contentMode: .fit)
          .scaleEffect(focused ? 1 : 0.9)
          .animation(.easeInOut(duration: 0.15), value: focused)
          .focusable(true)
  }
    
}
