//
//  VideoViewModel.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import SwiftUI

@Observable
class VideoViewModel {
    
    var subject: String
    var videos = [Video]()
    var nextPage: String?
    
    private let apiKey = "c3NYVq4s2LerCHmnnBa6fU4pwN3z0naARMD2FEzhS1yLZVouhgREV1pa"
    
    init(subject: String) {
        self.subject = subject
    }
    
    func fetchVideos(urlString: String? = nil) async {
        guard let url = URL(string: urlString ?? "https://api.pexels.com/videos/search?query=" + subject + "&per_page=1") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(PexelsResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.videos.append(contentsOf: response.videos)
                self.nextPage = response.nextPage
            }
        } catch {
            print("Error fetching videos: \(error)")
        }
    }
    
}
