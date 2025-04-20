//
//  SearchViewBar.swift
//  Crypto
//
//  Created by Agastya Nand on 18/04/25.
//

import SwiftUI

struct SearchViewBar: View {
    
    @Binding var SearchText: String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    SearchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
                
            
            TextField("Enter the coin name or symbol... ", text: $SearchText)
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
        .background {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundStyle(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        }
        .padding()
    }
}

struct SearchViewBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchViewBar(SearchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.light)
            
            SearchViewBar(SearchText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
