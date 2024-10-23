enum Destination: Hashable {
    case Entrance
    case User(id: String)

    init(deeplink: Deeplink) {
        let user = deeplink.url.pathComponents.last
        self = user == nil ? .Entrance : .User(id: user!)
    }
}
