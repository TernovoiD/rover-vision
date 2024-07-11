import Foundation

enum RoverName: String, CaseIterable {
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
