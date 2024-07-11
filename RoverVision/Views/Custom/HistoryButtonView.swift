import SwiftUI

struct HistoryButtonView: View {
    var body: some View {
        Image("History")
            .foregroundStyle(Color.layerOne)
            .padding()
            .background(Color.accenOne)
            .clipShape(Circle())
    }
}

#Preview {
    ZStack {
        Color.backgroundOne.ignoresSafeArea()
        HistoryButtonView()
    }
}
