import Foundation

struct Photo: Codable, Identifiable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover
    
    static let test = Photo(id: 1234,
                            sol: 1000,
                            camera: Camera(id: 5678, name: "FHAC", roverId: 90, fullName: "Front Hazard Avoidance Camera"),
                            imgSrc: "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FLB_486615455EDR_F0481570FHAZ00323M_.JPG",
                            earthDate: "June 6, 2015",
                            rover: Rover(id: 90,
                                         name: "Opportunity",
                                         landingDate: "June 6, 2015",
                                         launchDate: "June 6, 2015",
                                         status: "Active",
                                         maxSol: 1000,
                                         maxDate: "June 6, 2015",
                                         totalPhotos: 1235,
                                         cameras: [ ]))
}

struct Camera: Codable {
    let id: Int
    let name: String
    let roverId: Int
    let fullName: String
}

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
}

struct RoverCamera: Codable {
    let name: String
    let fullName: String
}
