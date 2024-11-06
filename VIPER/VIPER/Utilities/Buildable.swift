import SwiftUI

protocol Buildable where Self: View {
    associatedtype ViewType where ViewType: View
    static func build() -> ViewType
}
