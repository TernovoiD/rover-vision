import SwiftUI

struct RVNavigationBarModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.bottom)
            .background(
                Color.accenOne
                    .ignoresSafeArea()
                    .shadow(color: .black.opacity(0.4), radius: 3)
            )
    }
}

extension View {
    func addRVNavigationBarBackground() -> some View {
        self.modifier(RVNavigationBarModifier())
    }
}
