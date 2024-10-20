protocol AnalyticsEngine {
    func send(name: String, metadata: [String: String])
}

// TODO: do outside
struct CloudKitAnalyticsEngine: AnalyticsEngine {
    public func send(name: String, metadata: [String : String]) {
        print("send \(name) to CloudKit")
    }
}

struct FirebaseAnalyticsEngine: AnalyticsEngine {
    public func send(name: String, metadata: [String : String]) {
        print("send \(name) to Firebase")
    }
}
