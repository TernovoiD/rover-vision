import SwiftUI

struct HomeView: View {
    
    private enum Selector {
        case rover
        case camera
        case date
    }
    
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedPhotoURL: URL? = nil
    @State private var state: Selector?
    @State private var launching = true
    @State var scrollToTopVar = false
    
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
                        NavigationLink { HistoryView() { filter in
                            set(filter: filter)
                        }
                        } label: { HistoryButtonView() }
                    }
                    .padding()
                }
                if selectedPhotoURL != nil {
                    PhotoDetailView(imageURL: $selectedPhotoURL)
                }
                if viewModel.loading { loadingIcon }
                if state != .none { backgroundTint }
                cameraSelector
                roverSelector
                dateSelector
                LoadingView()
                    .offset(x: launching ? 0 : -1000)
            }
            .background(Color.backgroundOne)
        }
        .alert(viewModel.errorTitle, isPresented: $viewModel.error, actions: {
            Button("OK", role: .cancel) { viewModel.clearError() }
        }, message: { Text(viewModel.errorMessage) })
        .onAppear { stopLaunchingStateWithDelay() }
        .task { await viewModel.loadPhotos() }
    }
    
    private func stopLaunchingStateWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut) { launching = false }
        }
    }
    
    private func set(filter: Filter) {
        withAnimation(.easeInOut) {
            viewModel.filterDate = filter.date
            viewModel.filterRover = filter.rover
            viewModel.filterCamera = filter.camera
        }
        loadPhotos()
    }
    
    private func loadPhotos() {
        scrollToTopVar.toggle()
        Task { await viewModel.loadPhotos() }
    }
    
    private func updateState(to state: Selector? = nil) {
        withAnimation(.spring) { self.state = state }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}


// MARK: - UI elements

private extension HomeView {
    
    var photosList: some View {
        ScrollViewReader { reader in
            
            ScrollView(showsIndicators: true) {
                topBar.opacity(0)
                    .padding(10)
                LazyVStack(spacing: 15) {
                    Color.clear
                        .frame(maxHeight: 1)
                        .id("topScrollPoint")
                    ForEach(viewModel.photos) { photo in
                        PhotoCardView(photo: photo, selectedPhotoURL: $selectedPhotoURL)
                    }
                    if !viewModel.photos.isEmpty {
                        Color.clear.task { await viewModel.loadPhotos(fromNewPage: true) }
                    }
                }
                .padding(.horizontal)
                .onChange(of: scrollToTopVar) { _ in
                    withAnimation {
                        reader.scrollTo("topScrollPoint", anchor: .bottom)
                    }
                }
            }
            
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
                    Button(action: { updateState(to: .rover) }, label: {
                        FilterButtonView(imageName: "Rover", text: viewModel.filterRover.description())
                    })
                    Button(action: { updateState(to: .camera) }, label: {
                        FilterButtonView(imageName: "Camera",
                                         text: viewModel.filterCamera?.rawValue.uppercased() ?? "All")
                    })
                }
                saveFilterButton
            }
        }
    }
    
    var selectDateButton: some View {
        Button(action: { updateState(to: .date) }, label: {
            Image("Calendar")
                .frame(width: 40, height: 40)
        })
    }
    
    var saveFilterButton: some View {
        Button(action: {
            let currentFilter = viewModel.getCurrentFilter()
            viewModel.save(filter: currentFilter)
        }, label: {
            Image("PlusIcon")
                .frame(width: 40, height: 40)
                .background(Color.backgroundOne)
                .foregroundStyle(Color.layerOne)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        })
    }
    
    var backgroundTint: some View {
        Color.black.opacity(0.4).ignoresSafeArea()
            .onTapGesture { withAnimation(.easeInOut) { state = .none} }
    }
    
    var dateSelector: some View {
        VStack {
            Spacer()
            DateSelectorView(date: viewModel.filterDate) { date in
                viewModel.filterDate = date
                updateState()
                loadPhotos()
            } close: { updateState() }
                .padding()
            Spacer()
        }
        .ignoresSafeArea()
        .offset(y: state == .date ? 0 : 1000)
    }
    
    var cameraSelector: some View {
        VStack {
            Spacer()
            CameraSelectorView(camera: viewModel.filterCamera) { camera in
                viewModel.filterCamera = camera
                updateState()
                loadPhotos()
            } close: { updateState() }
        }
        .ignoresSafeArea()
        .offset(y: state == .camera ? 0 : 1000)
    }
    
    var roverSelector: some View {
        VStack {
            Spacer()
            RoverSelectorView(rover: viewModel.filterRover) { rover in
                viewModel.filterRover = rover
                updateState()
                loadPhotos()
            } close: { updateState() }
        }
        .ignoresSafeArea()
        .offset(y: state == .rover ? 0 : 1000)
    }
    
    var loadingIcon: some View {
        ProgressView()
            .scaleEffect(2)
            .padding(40)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
