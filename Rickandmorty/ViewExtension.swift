import SwiftUI

extension View {
    @ViewBuilder
    func navDestination<T: Identifiable & Hashable, Content:View>(with navigationItem: T.Type, @ViewBuilder content: @escaping (T) -> Content) -> some View {
        if #available(iOS 16, *) {
            self.navigationDestination(for: navigationItem, destination: content)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func showSheet<Content: View>(presentSheet: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        if #available(iOS 16, *) {
            self.sheet(isPresented: presentSheet) {
                content()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        } else {
            // otra opción sería implementar esta solución casera sin usar UIKit https://github.com/jorgemhtdev/Bottom-Sheet-Generic-SwiftU
            self.sheetPresentation(isPresented: presentSheet, sheetView: {
                content()
            }, onDismiss: { })
        }
    }
}
