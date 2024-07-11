import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var photos: [Photo] = [ ]
    let photosManager = NASAManager()
    let filtersManager = FilterCoreDataManager()
    
    // Filter
    @Published var filterDate = Date()
    @Published var filterRover: RoverName = .curiosity
    @Published var filterCamera: CameraName? = nil
    
    // Error handling
    @Published var error: Bool = false
    @Published var errorTitle: String = ""
    @Published var errorMessage: String = ""
    
    init() {
        Task { await loadPhotos(forFilter: getCurrentFilter(), onPage: 1) }
    }
    
    func loadPhotos(forFilter filter: Filter, onPage page: Int) async {
        do {
            let photos = try await photosManager.getPhotos(forRover: filter.rover, fromPage: page, usingCamera: filter.camera, onDate: filter.date)
            DispatchQueue.main.async {
                self.photos = photos
            }
        } catch let error {
            showError(title: "Unable to load Photos", description: error.localizedDescription)
        }
    }
    
    func getCurrentFilter() -> Filter {
        Filter(date: filterDate, rover: filterRover, camera: filterCamera)
    }
    
    func getFilters() -> [Filter] {
        do {
            return try filtersManager.getFilters()
        } catch let error {
            showError(title: "Unable to load Filters", description: error.localizedDescription)
            return [ ]
        }
    }
    
    func save(filter: Filter) {
        do {
            try filtersManager.create(filter: filter)
            showError(title: "Success", description: "Your current filter has been successfully saved in history.")
        } catch let error {
            showError(title: "Unable to save Filter", description: error.localizedDescription)
        }
    }
    
    func delete(filter: Filter) {
        do {
            try filtersManager.delete(filter: filter)
        } catch let error {
            showError(title: "Unable to delete Filter", description: error.localizedDescription)
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
