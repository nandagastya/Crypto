//
//  XMarkButton.swift
//  Crypto
//
//  Created by Agastya Nand on 21/04/25.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
            })
    }
}

#Preview {
    XMarkButton()
}
