import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            listOfPhotos
            VStack {
                HomeTopBarView()
                    .padding(.horizontal)
                    .padding(.bottom)
                    .background(
                        Color.accenOne
                            .ignoresSafeArea()
                            .shadow(color: .black.opacity(0.4), radius: 3)
                    )
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}, label: {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                            .foregroundStyle(Color.layerOne)
                            .padding(20)
                            .background(Color.accenOne)
                            .clipShape(Circle())
                    })
                }
                .padding()
            }
            
        }
        .background(Color.backgroundOne)
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}

private extension HomeView {
    
    var listOfPhotos: some View {
        ScrollView(showsIndicators: false) {
            HomeTopBarView().opacity(0)
                .padding(.bottom, 30)
            LazyVStack(spacing: 15) {
                ForEach(viewModel.photos) { photo in
                    PhotoCardView(photo: photo)
                }
            }
            .padding(.horizontal)
        }
    }
    
    
    
}
