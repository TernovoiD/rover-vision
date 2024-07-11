import SwiftUI

struct HistoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var filters: [Filter]
    
    var body: some View {
        ZStack {
            filtersList
            VStack {
                topBar
                    .addRVNavigationBarBackground()
                Spacer()
            }
        }
        .background(Color.backgroundOne)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HistoryView(filters: [ ])
}


// MARK: - UI elements

private extension HistoryView {
    
    var filtersList: some View {
        ScrollView(showsIndicators: false) {
            topBar.opacity(0)
                .padding(20)
            LazyVStack(spacing: 15) {
                ForEach(filters) { _ in
                    FilterCardView()
                }
            }
            .padding(.horizontal)
        }
    }
    
    var topBar: some View {
        HStack {
            Button(action: { dismiss() }, label: {
                Image("Left")
            })
            Spacer()
            Text("History")
                .font(.largeTitle.bold())
                .foregroundStyle(Color.layerOne)
            Spacer()
            Image("Left").opacity(0)
        }
    }
}

