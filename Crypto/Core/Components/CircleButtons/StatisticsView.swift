//
//  StatisticsView.swift
//  Crypto
//
//  Created by Agastya Nand on 19/04/25.
//
import SwiftUI

struct StatisticsView: View {
    let stat: StatisticsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)

            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)

            HStack(spacing: 4) {
                Image(systemName: "arrow.up")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPrecentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.green : Color.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)

        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
       
    }
}

#Preview {
    StatisticsView(stat: DeveloperPreview.instance.stat1)
}
