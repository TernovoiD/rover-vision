import Foundation

struct Filter: Identifiable {
    let id: UUID
    let date: Date
    let rover: RoverName
    let camera: CameraName?
    
    init(id: UUID, date: Date, rover: RoverName, camera: CameraName? = nil) {
        self.id = id
        self.date = date
        self.rover = rover
        self.camera = camera
    }
    
    init(date: Date, rover: RoverName, camera: CameraName? = nil) {
        self.id = UUID()
        self.date = date
        self.rover = rover
        self.camera = camera
    }
}
