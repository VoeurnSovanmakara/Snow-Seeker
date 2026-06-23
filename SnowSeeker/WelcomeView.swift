//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by sovanmakara on 19/6/26.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ContentUnavailableView(
            "SnowSeeker",
            systemImage: "mountain.2.fill",
            description: Text(
                "Choose a resort from the sidebar to start exploring."
            )
        )
    }
}

#Preview {
    WelcomeView()
}
