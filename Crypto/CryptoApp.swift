//
//  CryptoApp.swift
//  Crypto
//
//  Created by Agastya Nand on 21/01/25.
//
//import SwiftUI
//
//@main
//struct CryptoApp: App {
//    
//    @StateObject private var vm = HomeViewModel()
//    var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                HomeView()
//                    .navigationBarBackButtonHidden(true)
//            }
//            .environmentObject(vm)
//        }
//    }
//}
import SwiftUI


@main
struct CryptoApp: App {
    @StateObject private var vm = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarBackButtonHidden(true)
            }
            .environmentObject(vm)
        }
    }
}

