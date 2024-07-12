import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var photos: [Photo] = [ ]
    let photosManager = NASAManager()
    let filtersManager = FilterCoreDataManager()
    
    // Filter
    @Published var filterDate = Date()
    @Published var filterRover: RoverName = .curiosity
    @Published var filterCamera: CameraName? = nil
    @Published var currentPage = 1
    
    // Error handling
    @Published var error: Bool = false
    @Published var errorTitle: String = ""
    @Published var errorMessage: String = ""
    
    // Loading state
    @Published var loading: Bool = false
    
    init() {
        Task { await loadPhotos() }
    }
    
    func loadPhotos() async {
        loadingState(true)
        do {
            let filter = getCurrentFilter()
            let photos = try await photosManager.getPhotos(forRover: filter.rover, fromPage: 1, usingCamera: filter.camera, onDate: filter.date)
            DispatchQueue.main.async {
                self.photos = photos
                self.currentPage = 1
            }
        } catch let error {
            showError(title: "Unable to load Photos", description: error.localizedDescription)
        }
        loadingState(false)
    }
    
    func loadMorePhotos() async {
        loadingState(true)
        do {
            let filter = getCurrentFilter()
            let newPage = currentPage + 1
            let photos = try await photosManager.getPhotos(forRover: filter.rover, fromPage: newPage, usingCamera: filter.camera, onDate: filter.date)
            DispatchQueue.main.async {
                self.photos.append(contentsOf: photos)
                self.currentPage = newPage
            }
        } catch let error {
            showError(title: "Unable to load Photos", description: error.localizedDescription)
        }
        loadingState(false)
    }
    
    private func loadingState(_ state: Bool) {
        DispatchQueue.main.async { self.loading = state }
    }
    
    func getCurrentFilter() -> Filter {
        Filter(date: filterDate, rover: filterRover, camera: filterCamera)
    }
    
    func save(filter: Filter) {
        do {
            try filtersManager.create(filter: filter)
            showError(title: "Success", description: "Your current filter has been successfully saved in history.")
        } catch let error {
            showError(title: "Unable to save Filter", description: error.localizedDescription)
        }
    }
}


// MARK: - Error handling

extension HomeViewModel {
    
    func showError(title: String, description: String) {
        errorTitle = title
        errorMessage = description
        error = true
    }
    
    func clearError() {
        error = false
        errorMessage = ""
        errorTitle = ""
    }
}
