import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State var selectedPhotoURL: URL? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                photosList
                VStack {
                    topBar
                        .addRVNavigationBarBackground()
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink { HistoryView(filters: viewModel.getFilters()) } label: { HistoryButtonView() }
                    }
                    .padding()
                }
                if selectedPhotoURL != nil {
                    PhotoDetailView(imageURL: $selectedPhotoURL)
                }
            }
            .background(Color.backgroundOne)
            .alert(viewModel.errorTitle, isPresented: $viewModel.error, actions: {
                Button("OK", role: .cancel) { viewModel.clearError() }
            }, message: { Text(viewModel.errorMessage) })
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}


// MARK: - UI elements

private extension HomeView {
    
    var photosList: some View {
        ScrollView(showsIndicators: false) {
            topBar.opacity(0)
                .padding(20)
            LazyVStack(spacing: 15) {
                ForEach(viewModel.photos) { photo in
                    PhotoCardView(photo: photo, selectedPhotoURL: $selectedPhotoURL)
                }
            }
            .padding(.horizontal)
        }
    }
    
    var topBar: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("MARS.CAMERA")
                        .font(.largeTitle.bold())
                    Text(viewModel.filterDate.formatted(date: .abbreviated, time: .omitted))
                        .font(.body.bold())
                }
                Spacer()
                selectDateButton
            }
            .foregroundStyle(Color.layerOne)
            
            HStack(spacing: 25) {
                HStack(spacing: 10) {
                    Button(action: {}, label: {
                        FilterButtonView(imageName: "Rover", text: viewModel.filterRover.description())
                    })
                    Button(action: {}, label: {
                        FilterButtonView(imageName: "Camera", text: viewModel.filterCamera?.description() ?? "All")
                    })
                }
                saveFilterButton
            }
        }
    }
    
    var selectDateButton: some View {
        Button(action: {}, label: {
            Image("Calendar")
                .frame(width: 40, height: 40)
        })
    }
    
    var saveFilterButton: some View {
        Button(action: {
            let currentFilter = viewModel.getCurrentFilter()
            viewModel.save(filter: currentFilter)
        }, label: {
            Image("AddIcon")
                .frame(width: 40, height: 40)
                .background(Color.backgroundOne)
                .foregroundStyle(Color.layerOne)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        })
    }
    
    
    
}
