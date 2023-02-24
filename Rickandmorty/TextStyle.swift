import Foundation
import SwiftUI

extension View {
    func nameStadiumTextStyle() -> some View {
        self.modifier(NameStadiumTextStyle())
    }
}

struct NameStadiumTextStyle: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme == .dark ? .black : .white)
            .padding(8)
            .background(Rectangle()
                .overlay(Material.ultraThin)
                .opacity(0.6)
                .cornerRadius(5))
    }
}
