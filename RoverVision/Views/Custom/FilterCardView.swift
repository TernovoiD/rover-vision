import SwiftUI

struct FilterCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            filter
            ImageInfoView(rover: "Curiosity", camera: "Front Hazard Avoidance Camera", date: "June 6, 2019")
        }
        .padding()
        .background(Color.backgroundOne
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .clipped()
            .shadow(color: .black.opacity(0.1), radius: 5)
        )
    }
    
    private var filter: some View {
        HStack {
            Color.accenOne
                .frame(height: 2)
            Text("Filters")
                .foregroundStyle(Color.accenOne)
                .font(.title2.weight(.bold))
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundOne.ignoresSafeArea()
        FilterCardView().padding()
    }
}
