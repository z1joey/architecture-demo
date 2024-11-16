import SwiftUICore

protocol ColorScheme: Equatable {
    var textPrimaryColor: Color { get }
    var textSecondaryColor: Color { get }
    var backgroundColor: Color { get }
}

struct DefaultColorScheme: ColorScheme {
    var textPrimaryColor: Color { .primary }
    var textSecondaryColor: Color { .secondary }
    var backgroundColor: Color  { Color("Background") }
}

struct NewMoneyScheme: ColorScheme {
    var textPrimaryColor: Color { .primary }
    var textSecondaryColor: Color { .secondary }
    var backgroundColor: Color  { Color("NewMoney") }
}
