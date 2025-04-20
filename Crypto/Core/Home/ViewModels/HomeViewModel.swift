//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Agastya Nand on 01/02/25.
//

//import Foundation
//import Combine
//
//class HomeViewModel : ObservableObject {
//    @Published var allCoins: [CoinModel] = []
//    @Published var portfolioCoins : [CoinModel] = []
//    
//    private let dataService = CoinDataService()
//    private var cancelables = Set<AnyCancellable>()
//    
////    init() {
////        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
////            self.allCoins.append(DeveloperPreview.instance.coin)
////            self.portfolioCoins.append(DeveloperPreview.instance.coin)
////        }
////        }
//    
//    init() {
//        addSubscribers()
//        }
//
//    
//    func addSubscribers(){
//        dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancelables)
//    }
//}
import Foundation
import Combine



class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticsModel] = []
    
    // MARK: - Published Properties
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var SearchText: String = ""
    
    // MARK: - Private Properties
    private let dataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
//    init() {
//        addSubscribers()
//        
//        // TEMP FIX: load dummy data
//        self.allCoins = [DeveloperPreview.instance.coin]
//        self.portfolioCoins = [DeveloperPreview.instance.coin]
//    }
//
    init() {
        addSubscribers()
        
        // TEMP DATA TO VERIFY UI WORKS
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.allCoins = [DeveloperPreview.instance.coin]
            self.portfolioCoins = [DeveloperPreview.instance.coin]
        }
    }

    
    // MARK: - Private Methods
//    private func addSubscribers() {
//        dataService.$allCoins
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] returnedCoins in
//                self?.allCoins = returnedCoins
//                // In a real app, you'd also filter/update portfolioCoins here
//            }
//            .store(in: &cancellables)
//    }
    func addSubscribers(){
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                print("✅ Fetched coins: \(returnedCoins.count)")
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        $SearchText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
            self?.statistics = returnedStats
            }
            .store(in: &cancellables)


    }
    
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticsModel] {
        var stats: [StatisticsModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }

        let marketCap = StatisticsModel(
            title: "Market Cap",
            value: data.marketCap,
            percentageChange: data.marketCapChangePercentage24HUsd
        )
        stats.append(marketCap)
        
        let volume = StatisticsModel(
            title: "24h Volume",
            value: data.Volume
        )
        stats.append(volume)

        let btcDominance = StatisticsModel(
            title: "BTC Dominance",
            value: data.btcDominance
        )
        stats.append(btcDominance)
        
        let portfolio = StatisticsModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        stats.append(portfolio)

        return stats
    }

}



