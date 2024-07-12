import SwiftUI

struct FilterCardView: View {
    
    let filter: Filter
    
    var body: some View {
        VStack(alignment: .leading) {
            filterHeader
            ImageInfoView(rover: filter.rover.description(),
                          camera: filter.camera?.description() ?? "All",
                          date: filter.date.formatted(date: .abbreviated, time: .omitted))
        }
        .padding()
        .background(Color.backgroundOne
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .clipped()
            .shadow(color: .black.opacity(0.1), radius: 5)
        )
    }
    
    private var filterHeader: some View {
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
        FilterCardView(filter: Filter(date: Date(), rover: .opportunity, camera: .chemcam)).padding()
    }
}
