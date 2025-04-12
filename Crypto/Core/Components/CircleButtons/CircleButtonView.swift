//
//  CircleButtonView.swift
//  Crypto
//
//  Created by Agastya Nand on 21/01/25.
//


//import SwiftUI
//
//struct CircleButtonView: View {
//    var body: some View {
//        Image(systemName: "info")
//            .font(.headline)
//            .foregroundColor(Color.theme.accent)
//            .frame(width: 50, height: 50)
//            .background(
//                Circle()
//                    .foregroundColor(Color.theme.background)
//            )
//            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
//            .padding()
//    }
//}
//
//
//struct PlusButtonView: View {
//    var body: some View {
//        Image(systemName: "plus.app.fill")
//            .font(.headline)
//            .foregroundColor(Color.theme.accent)
//            .frame(width: 50, height: 50)
//            .background(
//                Circle()
//                    .foregroundColor(Color.theme.background)
//            )
//            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
//            .padding()
//    }
//}
//
//struct ChevronButtonView: View {
//    var body: some View {
//        Image(systemName: "chevron.right")
//            .font(.headline)
//            .foregroundColor(Color.theme.accent)
//            .frame(width: 50, height: 50)
//            .background(
//                Circle()
//                    .foregroundColor(Color.theme.background)
//            )
//            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10, x: 0, y: 0)
//            .padding()
//    }
//}
//
//struct CircleButton_previews: PreviewProvider {
//    static var previews: some View{
//        Group {
//            CircleButtonView()
//                  .previewLayout(.sizeThatFits)
//      
//            PlusButtonView()
//                  .previewLayout(.sizeThatFits)
//                  .colorScheme(.dark)
//            
//            ChevronButtonView()
//                .previewLayout(.sizeThatFits)
//                .preferredColorScheme(.dark)
//          }
//    }
//}
import SwiftUI

// MARK: - Circle Button Style Modifier
struct CircleButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(Circle().foregroundColor(Color.theme.background))
            .shadow(color: Color.theme.accent.opacity(0.25), radius: 10)
            .padding()
    }
}

// MARK: - Info Button
struct CircleButtonView: View {
    var body: some View {
        Image(systemName: "info")
            .modifier(CircleButtonStyle())
    }
}

// MARK: - Plus Button
struct PlusButtonView: View {
    var body: some View {
        Image(systemName: "plus.app.fill")
            .modifier(CircleButtonStyle())
    }
}

// MARK: - Chevron Button
struct ChevronButtonView: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .modifier(CircleButtonStyle())
    }
}

// MARK: - Previews
struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView()
                .previewLayout(.sizeThatFits)
            
            PlusButtonView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
            
            ChevronButtonView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}

