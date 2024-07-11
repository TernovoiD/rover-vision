import SwiftUI

struct PhotoCardView: View {
    
    @StateObject var viewModel = PhotoCardViewModel()
    let photo: Photo
    @Binding var selectedPhotoURL: URL?
    
    var body: some View {
        HStack {
            ImageInfoView(rover: photo.rover.name, camera: photo.camera.fullName, date: photo.earthDate)
            Spacer()
            AsyncImage(url: viewModel.imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedPhotoURL = viewModel.imageURL
                            }
                        }
                } else if phase.error != nil {
                    Color.red
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                } else {
                    Color.blue
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
            }
        }
        .padding(8)
        .padding(.leading)
        .background(Color.backgroundOne
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .clipped()
            .shadow(color: .black.opacity(0.1), radius: 5)
        )
        .task {
            try? await viewModel.downloadImage(forURL: photo.imgSrc)
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundOne.ignoresSafeArea()
        PhotoCardView(photo: Photo.test, selectedPhotoURL: .constant(nil))
            .environmentObject(PhotoCardViewModel())
            .padding()
    }
}
