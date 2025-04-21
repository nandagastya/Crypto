//
//  HomeStatsView.swift
//  Crypto
//
//  Created by Agastya Nand on 19/04/25.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
//        if vm.statistics.isEmpty {
//            ProgressView("Loading Market Data...")
//                .progressViewStyle(CircularProgressViewStyle())
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//        } else {
            HStack {
                ForEach(vm.statistics) { stats in
                    StatisticsView(stat: stats)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
            }
            .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
        }
    }
//}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.HomeVM)
}
