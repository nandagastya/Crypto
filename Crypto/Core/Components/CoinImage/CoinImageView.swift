//
//  CoinImageView.swift
//  Crypto
//
//  Created by Agastya Nand on 21/04/25.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CoinImageView_previews: PreviewProvider {
    static var previews: some View{
        CoinImageView(coin: DeveloperPreview.instance.coin)
            .previewLayout(.sizeThatFits)
    }
}
