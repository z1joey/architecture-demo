import Foundation
 
func tr(_ key: String) -> String {
    let value = NSLocalizedString(key, comment: "\(key)_comment")

    #if DEBUG
    guard value != key else {
        fatalError("Invalid string key: \(key)")
    }
    #endif

    return value
}

func tr(_ key: String, args: CVarArg...) -> String {
    return String(format: tr(key), arguments: args)
}
