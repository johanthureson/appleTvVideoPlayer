//
//  ContentView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-04-04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            DailyMotionView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Tab 1")
                }
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Tab 2")
                }
        }
        
    }
}

#Preview {
    ContentView()
}
