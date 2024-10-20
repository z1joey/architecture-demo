// TODO: not needed
public final class AnalyticsManager {
    private static let engines: [AnalyticsEngine] = [
        CloudKitAnalyticsEngine(),
        FirebaseAnalyticsEngine()
    ]

    public static func log(event: AnalyticsEvent) {
        engines.forEach { $0.send(name: event.name, metadata: event.meta) }
    }
}
