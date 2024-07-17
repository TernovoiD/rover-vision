import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class NASAManager {
    private let baseURL = "https://api.nasa.gov/mars-photos/api/v1/"
    private let keyAPI = "e4NQ913gbybcoAX2fSDicFVdsxVt8xyxUMQgYjJ7"
    
    func getPhotos(forRover rover: RoverName,
                    fromPage page: Int? = nil,
                    usingCamera camera: CameraName? = nil,
                    onDate date: Date) async throws -> [Photo] {
        var urlString = baseURL + "rovers/\(rover)/photos?" + "earth_date=\(formatDate(date))"
        if let page { urlString += "&page=\(page)" }
        if let camera { urlString += "&camera=\(camera)" }
        urlString += "&api_key=\(keyAPI)"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.badUrl
        }
        
        return try await loadPhotos(fromURL: url)
    }
    
    private func loadPhotos(fromURL url: URL) async throws -> [Photo] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        struct NASAResponse: Decodable {
            let photos: [Photo]
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
        guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
        guard let responseFromNASA = try? decoder.decode(NASAResponse.self, from: data) else { throw NetworkError.failedToDecodeResponse }
        return responseFromNASA.photos
    }
    
    // Format date for API use
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

