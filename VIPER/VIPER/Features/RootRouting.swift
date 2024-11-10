extension RootView {
    struct Routing: Equatable {
        var tab: Int = 0
        var signInSheet: Bool = true
        var forceUpdateSheet: Bool = false
        var debugMenuSheet: Bool = false
        var userName: String?
    }
}
