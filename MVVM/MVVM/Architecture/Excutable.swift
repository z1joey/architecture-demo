protocol Excutable {
    associatedtype Dependency

    var dependency: Dependency { get }
    func execute()
}

