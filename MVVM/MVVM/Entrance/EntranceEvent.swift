import Analytics

extension EntranceView {
    enum EntranceEvent: AnalyticsEvent {
        case screenViewed

        var name: String {
            switch self {
            case .screenViewed: return "Entrance Viewed"
            }
        }

        var meta: [String : String] {
            switch self {
            case .screenViewed: return [:]
            }
        }

        func log() {
            AnalyticsManager.log(event: self)
        }
    }
}
