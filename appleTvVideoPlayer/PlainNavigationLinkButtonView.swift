//
//  PlainNavigationLinkButtonView.swift
//  appleTvVideoPlayer
//
//  Created by Johan Thureson on 2024-07-18.
//

import SwiftUI

struct PlainNavigationLinkButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    PlainNavigationLinkButtonView(configuration: configuration)
  }
}

struct PlainNavigationLinkButtonView: View {
  
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
