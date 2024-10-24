import SwiftUI

public struct CoolButton: View {
    @Binding public var title: String
    @Binding public var isLoading: Bool
    public var action: () -> Void

    public var body: some View {
        if isLoading {
            CircleProgress()
        } else {
            Button(title, action: action).font(.title3)
        }
    }

    public init(title: Binding<String>, isLoading: Binding<Bool>, action: @escaping () -> Void) {
        self._title = title
        self._isLoading = isLoading
        self.action = action
    }
}

private struct CircleProgress: View {
    @State var isLoading = false
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(Color.green, lineWidth: 5)
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(
                .linear.repeatForever(autoreverses: false), value: isLoading
            )
            .onAppear {
                isLoading = true
            }
    }
}

struct CoolButton_Previews: PreviewProvider {
    static var previews: some View {
        CoolButton(title: .constant("test"),isLoading: .constant(true)) {
            print("do something")
        }

        CoolButton(title: .constant("test"),isLoading: .constant(false)) {
            print("do something")
        }
    }
}
