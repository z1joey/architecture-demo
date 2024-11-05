import SwiftUI

protocol Buildable: AnyObject {
    associatedtype ViewType: View

    func build() -> ViewType
}
