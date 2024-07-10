import SwiftUI

struct PhotoInfoView: View {
    
    let rover: String
    let camera: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Rover: ").font(.body) + Text(rover).font(.body).bold()
            Text("Camera: ").font(.body) + Text(camera).font(.body).bold()
            Text("Date: ").font(.body) + Text(date).font(.body).bold()
        }
        .foregroundStyle(Color.systemTwo)
    }
}

#Preview {
    PhotoInfoView(rover: "Curiosity", camera: "Fron Hazard Avoidance Camera", date: "June 6, 2019")
}
