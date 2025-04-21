//
//  CoinLogoView.swift
//  Crypto
//
//  Created by Agastya Nand on 21/04/25.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel
    var body: some View {
        
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            
            
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 6)
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
            
                .foregroundStyle(Color.theme.secondaryText.opacity(0.05))
                .shadow(radius: 10)
        )
    }
}

#Preview {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}
