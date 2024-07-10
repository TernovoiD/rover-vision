import Foundation

struct Rover: Codable {
    let id: Int
    let name: String
    let landingDate: String
    let launchDate: String
    let status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let cameras: [RoverCamera]

    enum CodingKeys: String, CodingKey {
        case id, name, status, cameras
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
    }
}

struct RoverCamera: Codable {
    let name: String
    let fullName: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}
