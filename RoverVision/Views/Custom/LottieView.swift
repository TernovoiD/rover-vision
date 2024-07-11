import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let lottieFile: String
    let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.play()
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.animationSpeed = 1
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
}
