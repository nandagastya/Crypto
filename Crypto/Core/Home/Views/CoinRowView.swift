//
//  coinRowView.swift
//  Crypto
//
//  Created by Agastya Nand on 28/01/25.
//

import SwiftUI


struct CoinRowView: View {
    let coin : CoinModel
    let showcurrentHoldings: Bool
    
    var body: some View {
        HStack( spacing: 0) {
            leftColomn
            Spacer()
            
            if showcurrentHoldings{
                CentreColumn
            }
            Spacer()
            
            RightColumn
        }
    }
}

struct CoinRowView_Previews: PreviewProvider{
    static var previews: some View{
        Group {
            CoinRowView(coin: dev.coin, showcurrentHoldings: true)
                .previewLayout(.sizeThatFits)
            
            CoinRowView(coin: dev.coin, showcurrentHoldings: false)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)


        }
    }
}

extension CoinRowView{
    private var leftColomn : some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(width: 30)
            AsyncImage(url: URL(string: coin.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            } placeholder: {
                ProgressView()
            }
            
            Text("\(coin.symbol.uppercased())")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding(.leading, 6)
        }
    }
    
    private var CentreColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text(coin.currentHoldings?.asNumberString() ?? 0.asNumberString())
                
        }
        .foregroundColor(Color.theme.accent)
    }
    
    private var RightColumn : some View{
        VStack(alignment: .trailing) {
            Text("\(coin.currenPrice.asCurrencywith6Decimals())")
                .bold()
                .foregroundColor(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPrecentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color.theme.green : Color.theme.Red
                )
        }
        .frame(alignment: .trailing)

    }
}
