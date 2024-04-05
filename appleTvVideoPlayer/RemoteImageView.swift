//
//  RemoteImageView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-05.
//

import SwiftUI

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

