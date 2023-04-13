import Foundation

enum PKImageName {
    
    enum Pokemon: String {
        case mainIcon
        case buttonType
        
        var name: String {
            switch self {
            case .buttonType: return "flame.fill"
            case .mainIcon: return "person"
            }
        }
    }

    enum Settings: String {
        case mainIcon
        
        var name: String {
            switch self {
            case .mainIcon: return "gear"
            }
        }

    }
}
