import Foundation
import SwiftUI

extension View {
    func nameTextStyle() -> some View {
        self.modifier(NameTextStyle())
    }
    
    func titleTextStyle() -> some View {
        self.modifier(TitleTextStyle())
    }
}

struct NameTextStyle: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme != .dark ? .black : .white)
            .padding(8)
    }
}

struct TitleTextStyle: ViewModifier {
    
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .foregroundColor(colorScheme != .dark ? .black : .white)
            .font(.title)
            .font(Font.headline.weight(.bold))
            .padding(8)
    }
}
