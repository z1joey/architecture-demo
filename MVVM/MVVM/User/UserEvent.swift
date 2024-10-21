import Analytics

extension UserView {
    struct UserEvent: AnalyticsEvent {
        var name: String
        var meta: [String : String]
        
        static func screenViewed() -> UserEvent {
            .init(name: "User Viewed", meta: [:])
        }

        func log() {
            AnalyticsManager.log(event: self)
        }
    }
}
