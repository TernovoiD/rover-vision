import SwiftUI

struct ImageInfoView: View {
    
    let rover: String
    let camera: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Rover: ").font(.body) + Text(rover).font(.body).bold()
            Text("Camera: ").font(.body) + Text(camera).font(.body).bold()
            Text("Date: ").font(.body) + Text(transformDate(date)).font(.body).bold()
        }
        .foregroundStyle(Color.systemTwo)
    }
}

#Preview {
    ZStack {
        Color.backgroundOne.ignoresSafeArea()
        ImageInfoView(rover: "Curiosity", camera: "Front Hazard Avoidance Camera", date: "June 6, 2019")
    }
}

private extension ImageInfoView {
    func transformDate(_ input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM dd, yyyy"
        
        if let date = inputFormatter.date(from: input) {
            let output = outputFormatter.string(from: date)
            return output
        } else {
            return input
        }
    }
}
