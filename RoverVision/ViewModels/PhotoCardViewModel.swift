import Foundation

final class PhotoCardViewModel: ObservableObject {
    
    private let session = URLSession(configuration: .default)
    @Published var imageURL: URL?

    func downloadImage(forURL urlString: String) async throws {
        guard let url = URL(string: urlString) else { return }
        let (data, _) = try await session.data(from: url)
        let dataURL = URL(string: "data:image/png;base64," + data.base64EncodedString())
        DispatchQueue.main.async {
            self.imageURL = dataURL
        }
    }
}
