//
//  ContentView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-04.
//

import SwiftUI

struct ContentView: View {
    
    @State private var natureTabViewModel = VideoViewModel(subject: "nature")
    @State private var anmilsTabViewModel = VideoViewModel(subject: "animals")
    
    var body: some View {
        NavigationView {
            TabView {
                VideoGridView(viewModel: natureTabViewModel)
                    .tabItem {
                        Text("Nature")
                    }
                VideoGridView(viewModel: anmilsTabViewModel)
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

