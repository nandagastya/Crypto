//
//  UIApplication.swift
//  Crypto
//
//  Created by Agastya Nand on 18/04/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
