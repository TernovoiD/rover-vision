import Foundation

final class HistoryViewModel: ObservableObject {
    
    @Published var filters: [Filter] = [ ]
    private let filtersManager = FilterCoreDataManager.shared
    
    // Error handling
    @Published var error: Bool = false
    @Published var errorTitle: String = ""
    @Published var errorMessage: String = ""
    
    init() {
        getFilters()
    }
    
    func getFilters() {
        do {
            let storageFilters = try filtersManager.getFilters()
            filters = storageFilters.sorted(by: { $0.date > $1.date })
        } catch let error {
            showError(title: "Unable to load Filters", description: error.localizedDescription)
        }
    }

    func delete(filter: Filter) {
        do {
            try filtersManager.delete(filter: filter)
            filters.removeAll(where: { $0.id == filter.id })
        } catch let error {
            showError(title: "Unable to delete Filter", description: error.localizedDescription)
        }
    }
    
}


// MARK: - Error handling

extension HistoryViewModel {
    
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
