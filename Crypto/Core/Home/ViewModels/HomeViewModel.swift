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
    
    // MARK: - Published Properties
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    // MARK: - Private Properties
    private let dataService = CoinDataService()
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
    }

}



