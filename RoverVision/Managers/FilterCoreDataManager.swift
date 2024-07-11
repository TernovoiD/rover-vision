import Foundation
import CoreData

final class FilterCoreDataManager {
    
    let container = NSPersistentContainer(name: "RoverVisionContainer")
    
    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func create(filter: Filter) throws {
        let filterEntity = FilterEntity(context: container.viewContext)
        filterEntity.id = filter.id
        filterEntity.date = filter.date
        filterEntity.rover = filter.rover.description()
        if let camera = filter.camera?.description() {
            filterEntity.camera = camera
        }
        try saveChanges()
    }
    
    func getFilters() throws -> [Filter] {
        let filterEntities = try getFilterEntities()
        return transformToModel(entities: filterEntities)
    }
    
    func delete(filter: Filter) throws {
        let filterEntities = try getFilterEntities()
        let searchedEntities = filterEntities.filter({ $0.id == filter.id })
        for entity in searchedEntities {
            container.viewContext.delete(entity)
        }
        try saveChanges()
    }
}


// Private methods

private extension FilterCoreDataManager {
    
    func transformToModel(entities: [FilterEntity]) -> [Filter] {
        var filters: [Filter] = [ ]
        for entity in entities {
            let rover = RoverName.allCases.first(where: { $0.description() == entity.rover })
            let camera = CameraName.allCases.first(where: { $0.description() == entity.camera })
            
            let filter = Filter(id: entity.id ?? UUID(),
                                date: entity.date ?? Date(),
                                rover: rover ?? .curiosity,
                                camera: camera)
            filters.append(filter)
        }
        return filters
    }
    
    func saveChanges() throws {
        try container.viewContext.save()
    }
    
    func getFilterEntities() throws -> [FilterEntity] {
        let request = NSFetchRequest<FilterEntity>(entityName: "FilterEntity")
        return try container.viewContext.fetch(request)
    }
}
