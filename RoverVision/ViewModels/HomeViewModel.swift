import Foundation

final class HomeViewModel: ObservableObject {
    
    @Published var photos: [Photo] = [ ]
    let photosManager = NASAManager()
    
    init() {
        Task {
            await loadPhotos()
        }
    }
    
    func loadPhotos() async {
        do {
            let photos = try await photosManager.getPhotos(forRover: .curiosity, onDate: Date())
            DispatchQueue.main.async {
                self.photos = photos
            }
        } catch let error {
            print(error)
        }
    }
}
