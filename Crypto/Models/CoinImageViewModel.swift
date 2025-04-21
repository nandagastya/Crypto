//
//  CoinImageViewMovel.swift
//  Crypto
//
//  Created by Agastya Nand on 21/04/25.
//
import Foundation
import SwiftUI
import Combine
//import Combine
//
//class CoinImageViewModel: ObservableObject {
//    @Published var image: UIImage? = nil
//    @Published var isLoading: Bool = false
//    
//    private var imageSubscription: AnyCancellable?
//    private let coin: CoinModel
//    
//    init(coin: CoinModel) {
//        self.coin = coin
//        getImage()
//    }
//    
//    func getImage() {
//        guard let url = URL(string: coin.image) else { return }
//        isLoading = true
//        
//        imageSubscription = NetworkingManager.download(url: url)
//            .tryMap { data -> UIImage? in
//                UIImage(data: data)
//            }
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { [weak self] _ in
//                self?.isLoading = false
//            }, receiveValue: { [weak self] returnedImage in
//                self?.image = returnedImage
//                self?.imageSubscription?.cancel()
//            })
//    }
//}

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataservice: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataservice = CoinImageService(coin : coin)
        self.isLoading = true
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        dataservice.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
