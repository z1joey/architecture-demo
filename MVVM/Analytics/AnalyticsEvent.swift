public protocol AnalyticsEvent {
    var name: String { get }
    var meta: [String: String] { get }
}
