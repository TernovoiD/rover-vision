import Foundation

struct Photo: Codable, Identifiable {
    let id: Int
    let sol: Int
    let camera: Camera
    let imgSrc: String
    let earthDate: String
    let rover: Rover

    enum CodingKeys: String, CodingKey {
        case id, sol, camera
        case imgSrc = "img_src"
        case earthDate = "earth_date"
        case rover
    }
    
    static let test = Photo(id: 1234,
                            sol: 1000,
                            camera: Camera(id: 5678, name: "FHAC", roverID: 90, fullName: "Front Hazard Avoidance Camera"),
                            imgSrc: "",
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
