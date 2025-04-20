//
//  MarketDataService.swift
//  Crypto
//
//  Created by Agastya Nand on 20/04/25.
//
import Foundation
import Combine

class MarketDataService {

    @Published var marketData: MarketDataModel? = nil
    private var marketDataSubscription: AnyCancellable?

    init() {
        getData()
    }

    private func getData() {
        guard let url = URL(string: "https://pro-api.coingecko.com/api/v3/global") else { return }

        let headers = [
            "x-cg-pro-api-key": "YOUR_API_KEY" // 🔐 Replace with your actual CoinGecko Pro API key
        ]

        marketDataSubscription = NetworkingManager.download(url: url, headers: headers)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("✅ Finished downloading market data")
                case .failure(let error):
                    print("❌ Failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] returnedGlobalData in
                print("✅ Successfully decoded: \(returnedGlobalData)")
                self?.marketData = returnedGlobalData.data
            })

    }
}

