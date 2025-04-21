//
//  HomeView.swift
//  Crypto
//
//  Created by Agastya Nand on 21/01/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false //animate right
    @State private var showPortfolioView: Bool = false//new sheet
    
    var body: some View {
        ZStack {
            // Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView(SearchText: .constant(""))
                        .environmentObject(vm)
                }
            
            // Content layer
            VStack {
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchViewBar(SearchText: $vm.searchText)
                
                columnItems
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                                
                Spacer(minLength: 0)
                    
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View{
        NavigationView {
            HomeView()
                .navigationBarBackButtonHidden(true)
        }
        .environmentObject(HomeViewModel())  // Ensure the HomeViewModel is provided
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            if !showPortfolio {
                CircleButtonView()
                    .background {
                        CircleButtonAnimationView(animate: $showPortfolio)
                    }
            } else {
                PlusButtonView()
                    .onTapGesture(perform: {
                        if showPortfolio {
                            showPortfolioView.toggle()
                        }
                    })
                    .background {
                        CircleButtonAnimationView(animate: $showPortfolio)
                    }
            }
            
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            ChevronButtonView()
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showcurrentHoldings: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showcurrentHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnItems: some View {
        HStack {
            Text("coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
                Spacer()
            }
            Text("Price")
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
