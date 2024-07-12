import Foundation

enum RoverName: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case opportunity
    case curiosity
    case spirit

    func description() -> String {
        switch self {
        case .opportunity:
            "Opportunity"
        case .curiosity:
            "Curiosity"
        case .spirit:
            "Spirit"
        }
    }
}
