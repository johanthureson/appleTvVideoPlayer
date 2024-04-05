//
//  DailyMotionView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-04.
//

import SwiftUI

struct DailyMotionView: View {
    @State private var videos: [Video] = []

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CategoryRowView(videos: videos)
                CategoryRowView(videos: videos)
                CategoryRowView(videos: videos)
                CategoryRowView(videos: videos)
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
