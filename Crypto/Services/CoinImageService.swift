//
//  CoinImageService.swift
//  Crypto
//
//  Created by Agastya Nand on 21/04/25.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    private let coin: CoinModel
    
    private var imageSubscription : AnyCancellable?
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    private func getCoinImage(){
        guard let url = URL(string: coin.image) else { return }

        imageSubscription = NetworkingManager.download(url: url) // No headers for public API
            .tryMap({ (data) -> UIImage? in
                 return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImages in
                self?.image = returnedImages
                self?.imageSubscription?.cancel()
            })

    }
}
