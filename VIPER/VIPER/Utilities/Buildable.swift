import SwiftUI

protocol Buildable {
    associatedtype Content: View
    func build() -> Content
}
