//
//  DailyMotionView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-04.
//

import SwiftUI
import Combine

struct Video: Identifiable, Decodable {
    let id: String
    let title: String
    let language: String
}

struct VideoList: Decodable {
    let list: [Video]
}

struct DailyMotionView: View {
    @State private var videos: [Video] = []

    var body: some View {
        VStack {
            Text("News")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(videos, id: \.id) { video in
                        NavigationLink(destination: Text("hej")) {
                            VStack {
                                RemoteImage(url: "https://api.dailymotion.com/video/\(video.id)?fields=thumbnail_url")
                                    .frame(maxWidth: 460)
                                    .cornerRadius(10)
                                    .padding()
                                Text(video.title)
                            }
                        }
                        .buttonStyle(PlainNavigationLinkButtonStyle())
                    }
                }
            }
        }.onAppear(perform: fetchVideos)
    }

    func fetchVideos() {
        guard let url = URL(string: "https://api.dailymotion.com/videos?fields=id,title,language&channel=news&limit=10") else { return }
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

  let configuration: ButtonStyle.Configuration

  var body: some View {
    configuration.label
      .scaleEffect(focused ? 1.1 : 1)
      .focusable(true)
  }
}
