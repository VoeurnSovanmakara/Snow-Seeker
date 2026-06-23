//
//  SkiDetailsView.swift
//  SnowSeeker
//
//  Created by sovanmakara on 19/6/26.
//

import SwiftUI

struct SkiDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            StatView(label: "Elevation", value: "\(resort.elevation)m")
            StatView(label: "Snow", value: "\(resort.snowDepth)cm")
        }
        .frame(maxWidth: .infinity)
    }
}

struct StatView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .textCase(.uppercase)
                .tracking(0.5)
            Text(value)
                .font(.title3.bold())
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SkiDetailsView(resort: .example)
}
