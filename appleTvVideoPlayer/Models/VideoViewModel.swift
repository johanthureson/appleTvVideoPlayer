//
//  VideoViewModel.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-10.
//

import Combine
import SwiftUI

@Observable
class VideoViewModel {
    var videos = [Video]()
    var nextPage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let apiKey = "c3NYVq4s2LerCHmnnBa6fU4pwN3z0naARMD2FEzhS1yLZVouhgREV1pa"
    
    init() {
        fetchVideos()
    }
    
    func fetchVideos(urlString: String? = nil) {
        guard let url = URL(string: urlString ?? "https://api.pexels.com/videos/popular?per_page=15") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: PexelsResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { response in
                self.videos.append(contentsOf: response.videos)
                self.nextPage = response.nextPage
            })
            .store(in: &cancellables)
    }
}
