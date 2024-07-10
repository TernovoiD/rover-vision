import SwiftUI

struct PhotoCardView: View {
    
    let photo: Photo
    
    var body: some View {
        HStack {
            PhotoInfoView(rover: photo.rover.name, camera: photo.camera.fullName, date: photo.earthDate)
            Spacer()
            Color.gray
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
        .padding(10)
        .background(Color.backgroundOne
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .clipped()
            .shadow(color: .black.opacity(0.1), radius: 5)
        )
    }
}

#Preview {
    ZStack {
        Color.accenOne.ignoresSafeArea()
        PhotoCardView(photo: Photo.test)
            .padding()
    }
}
