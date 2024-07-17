import SwiftUI

struct PhotoDetailView: View {
    @Binding var imageURL: URL?
    @State private var screenW = 0.0
    @State private var screenH = 0.0
    @State private var scale = 1.0
    @State private var lastScale = 0.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea()
                image
                    .scaleEffect(scale)
                    .offset(offset)
                    .scaledToFit()
                    .gesture(
                        MagnificationGesture(minimumScaleDelta: 0)
                            .onChanged({ value in
                                withAnimation(.interactiveSpring()) {
                                    scale = handleScaleChange(value)
                                }
                            })
                            .onEnded({ _ in lastScale = scale })
                            .simultaneously(
                                with: DragGesture(minimumDistance: 0)
                                    .onChanged({ value in
                                        withAnimation(.interactiveSpring()) {
                                            offset = handleOffsetChange(value.translation)
                                        }
                                    })
                                    .onEnded({ _ in lastOffset = offset })
                            )
                    )
                    .onAppear {
                        screenW = geometry.size.width
                        screenH = geometry.size.height
                    }
                closeButton
            }
        }
    }
    
    private func handleScaleChange(_ zoom: CGFloat) -> CGFloat {
        let scale = lastScale + zoom - (lastScale == 0 ? 0 : 1)
        return scale >= 1 ? scale : 1
    }
    
    private func handleOffsetChange(_ offset: CGSize) -> CGSize {
        var newOffset: CGSize = .zero
        
        newOffset.width = offset.width + lastOffset.width
        newOffset.height = offset.height + lastOffset.height
        
        return newOffset
    }
}


#Preview {
    PhotoDetailView(imageURL: .constant(nil))
}

private extension PhotoDetailView {
    var image: some View {
        AsyncImage(url: imageURL) { image in
            image.resizable()
        } placeholder: {
            Color.red
                .overlay {
                    Text("Error")
                        .font(.largeTitle.bold())
                        .foregroundStyle(Color.white)
                }
        }
    }
    
    var closeButton: some View {
        VStack {
            HStack {
                Button(action: {
                    imageURL = nil
                }, label: {
                    Image("Close-1")
                        .padding()
                })
                Spacer()
            }
            Spacer()
        }
    }
}
