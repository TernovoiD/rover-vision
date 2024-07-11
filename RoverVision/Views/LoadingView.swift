import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                LottieView(lottieFile: "Loader_Test")
                    .frame(height: 150)
                    .scaleEffect(2)
                    .padding(.bottom, 30)
            }
            RoundedRectangle(cornerRadius: 20)
                        .fill(Color.accenOne)
                        .frame(width: 100, height: 100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 1)
                        )
        }
        .background(Color.backgroundOne)
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
