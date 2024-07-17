import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var photos: [Photo] = [ ]
    private let photosManager = NASAManager()
    private let filtersManager = FilterCoreDataManager.shared
    
    // Filter
    @Published var filterDate = Date()
    @Published var filterRover: RoverName = .curiosity
    @Published var filterCamera: CameraName? = nil
    private var currentPage = 1
    
    // Error handling
    @Published var error: Bool = false
    @Published var errorTitle: String = ""
    @Published var errorMessage: String = ""
    
    // Loading state
    @Published var loading: Bool = false
    
    func loadPhotos(fromNewPage: Bool = false) async {
        guard self.loading == false else { return }
        loadingState(true)
        let filter = getCurrentFilter()
        currentPage = fromNewPage ? currentPage + 1 : 1
        do {
            let photos = try await photosManager.getPhotos(forRover: filter.rover, fromPage: currentPage, usingCamera: filter.camera, onDate: filter.date)
            show(photos: photos)
        } catch let error {
            showError(title: "Unable to load Photos", description: error.localizedDescription)
        }
        loadingState(false)
    }
    
    private func show(photos: [Photo]) {
        DispatchQueue.main.async {
            if self.currentPage == 1 {
                self.photos = photos
            } else {
                self.photos.append(contentsOf: photos)
            }
        }
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
