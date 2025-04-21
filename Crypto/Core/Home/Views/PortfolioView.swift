//
//  PortfolioView.swift
//  Crypto
//
//  Created by Agastya Nand on 21/04/25.
//
import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var SearchText: String
    @State private var selectedCoin: CoinModel? = nil
    @State private var QuantityText: String = ""
    @State private var checkMark: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchViewBar(SearchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        PortfolioInputSection
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    TrailingNavBarButtons
                    
                    .font(.headline)
                }
            }
        }
    }
    
    
    
    private func PortfolioSearchBar() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    SearchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Enter the coin name or symbol...", text: $SearchText)
                .disableAutocorrection(true)
                .foregroundStyle(Color.theme.accent)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(SearchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            SearchText = ""
                        }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .foregroundStyle(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10)
        )
        .padding(.horizontal)
    }
}

#Preview {
    PortfolioView(SearchText: .constant(""))
        .environmentObject(DeveloperPreview.instance.HomeVM)
}

extension PortfolioView {
    private var coinLogoList: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width : 75)
                        .padding(4)
                        .onTapGesture(perform: {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        })
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
        }
    }
    
    private func getCurrentVlue() -> Double{
        if let quantity = Double(QuantityText){
            return quantity * (selectedCoin?.currenPrice ?? 0)
        }
        return 0
    }
    
    private var PortfolioInputSection: some View{
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                
                Spacer()
                
                Text(selectedCoin?.currenPrice.asCurrencywith6Decimals() ?? "")
            }
            .padding(.top)
            
            Divider()
            
            HStack {
                Text("Current holding coins")
                Spacer()
                TextField("Ex: 1.4", text: $QuantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentVlue().asCurrencyWith2Decimals())
            }
        }
    }
    
    private var TrailingNavBarButtons: some View{
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .opacity(checkMark ? 1.0 : 0.0)
            Button {
                
            } label: {
                Text("Save".uppercased())
            }
            .opacity(
                selectedCoin != nil &&
                Double(QuantityText) != nil &&
                selectedCoin?.currentHoldings != Double(QuantityText)
                ? 1.0 : 0.0
            )

            
        }
    }
    
    private func saveButtonPressed() {
        
        guard let coin = selectedCoin else {return}
        
        //save to portfolio
        
        //show checkmark
        withAnimation(.easeIn) {
            checkMark = true
            removeSelectedCoins()
        }
        
        //hideKeyboard
        UIApplication.shared.endEditing()
        
        //hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut) {
                checkMark = false
            }
        }
    }
    
    private func removeSelectedCoins() {
        selectedCoin = nil
        vm.searchText = ""
    }
}
