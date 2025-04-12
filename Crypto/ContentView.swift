//
//  ContentView.swift
//  Crypto
//
//  Created by Agastya Nand on 21/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
            
            VStack {
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                Text("Secondary Text Color")
                    .foregroundColor(Color.theme.secondaryText)
                Text("Green Color")
                    .foregroundColor(Color.theme.green)
                
                Text("Red Color")
                    .foregroundColor(Color.theme.Red)
            }
            .font(.headline)
        }
    }
}

#Preview {
    ContentView()
}
