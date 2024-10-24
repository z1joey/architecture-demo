protocol AnalyticsEngine {
    func auth()
    func send(name: String, metadata: [String: String])
}

// TODO: do outside
struct CloudKitAnalyticsEngine: AnalyticsEngine {
    public func auth() {
        print("CloudKit finished authentication")
    }

    public func send(name: String, metadata: [String : String]) {
        print("CloudKit received event - \(name)")
    }
}

struct FirebaseAnalyticsEngine: AnalyticsEngine {
    public func auth() {
        print("Firebase finished authentication")
    }

    public func send(name: String, metadata: [String : String]) {
        print("Firebase received event - \(name)")
    }
}
