//
//  ContentView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-04.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel1 = VideoViewModel(subject: "nature")
    @State private var viewModel2 = VideoViewModel(subject: "animals")
    
    var body: some View {
        NavigationView {
            TabView {
                VideoGridView(viewModel: viewModel1)
                    .tabItem {
                        Text("Nature")
                    }
                VideoGridView(viewModel: viewModel2)
                    .tabItem {
                        Text("Animals")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}

