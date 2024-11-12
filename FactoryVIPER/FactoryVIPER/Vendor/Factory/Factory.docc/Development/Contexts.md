# Contexts

Changing injection results under special circumstances.

## Overview

Developers often use Factory to mock data for previews and unit tests. Now Factory 2.1 extends these capabilities by allowing them to specify dependencies based on the application's current _context_.

What if, for example, you **never** want your application's analytics library to be called when running unit tests? 

Piece of cake. Just register a new override for that particular context.

```swift
extension Container: AutoRegistering {
    public func autoRegister() {
        #if DEBUG
        container.analytics
            .context(.test) { MockAnalyticsEngine() }
        #endif
    }
}
```
Factory makes it easy.

## Contexts

Factory 2.1 provides quite a few predefined contexts for your use. They are:

* **arg(String)** - application is launched with a particular argument.
* **args([String])** - application is launched with one of several arguments.
* **preview** - application is running in Xcode Preview mode
* **test** - application is running in Xcode Unit Test mode
* **debug** - application is running in Xcode DEBUG mode
* **simulator** - application is running within an Xcode simulator
* **device** - application is running on an actual device

Let's dive in.

## Some Examples

### • onTest

As mentioned, the Factory closure associated with this context is used whenever your application or library is running unit tests using XCTest. 
```swift
container.analytics
    .context(.test) { MockAnalyticsEngine() }
```
There's also a shortcut version:

```swift
container.analytics
    .onTest { MockAnalyticsEngine() }
```
Having contexts built into Factory saves you from having to go to StackOverflow in an attempt to figure out how to do the same thing for yourself.
```swift
if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
    container.analytics.register { MockAnalyticsEngine() }
}
```
Using onTest is much easier.

*By the way, checking the environment for XCTestConfigurationFilePath doesn't work if your tests are launched from the command line using swift test. So much for StackOverflow.*

### • onPreview

This specifies a dependency that will be used whenever your app or module is running SwiftUI Previews.

```swift
container.myServiceType
    .onPreview { MockService() }
```
Which obviously makes your preview code itself much simpler.
```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
You can, of course, still use the mechanisms shown in <doc:Previews>.
### • onDebug

Triggered whenever your application is running in debug mode in simulators, on a device, or when running unit tests.

> Note: that there's no `release` context. Just use the standard `register` syntax in that case.

### •  onSimulator / onDevice

Pretty apparent. What may not be so apparent, however, is that unlike all of the above these two contexts are also available in release builds. 

### • onArg

The `arg` context is a powerful tool to have when you want to UITest your application and you want to change its behavior.

As shown in the <doc:Testing> section the test case itself is pretty standard.

```swift
import XCTest

final class FactoryDemoUITests: XCTestCase {
    func testExample() throws {
        let app = XCUIApplication()
        app.launchArguments.append("mock1")
        app.launch()

        let welcome = app.staticTexts["Mock Number 1! for Michael"]
        XCTAssert(welcome.exists)
    }
}   
```
The shortcut comes in the application itself when we want to check the launch arguments to see what registrations we might want to change.
```swift
import Foundation
import Factory

extension Container: AutoRegistering {
    public func autoRegister() {
        #if DEBUG
        myServiceType
            .onArg("mock0") { EmptyService() }
            .onArg("mock1") { MockServiceN(1) }
            .onArg("error") { MockError(404) }
        #endif
    }
}
```

### • onArgs
Similar to arg, but let's you use the same factory when any of several arguments are passed.
```swift
myServiceType
    .onArgs(["mock0", "mock1", "mock3"]) { 
        EmptyService()
    }
```

## Runtime Arguments

You can also add and remove your own arguments at runtime. Consider this...
```swift
FactoryContext.setArg("light", forKey: "theme")
FactoryContext.removeArg(forKey: "theme")

myStyleSystem { StandardTheme() }
    .onArg("light") { LightTheme() }
    .onArg("dark") { DarkTheme() }
```

## Multiple Contexts

As you may have noticed above in the `arg` example, chaining multiple contexts together work just as you'd expect and are specified using Factory's modifier syntax.

Here's an example of specifying separate services depending on context.
```swift
container.myServiceType
    .onPreview { MockService() }
    .onTest { UnitTestMockService() }
```

And here's an example saying we want the same dependency under multiple contexts.
```swift
container.myServiceType
    .context(.simulator, .test) { MockService() }
```
Which brings us to...

## Context Precedence

Registering multiple contexts could lead one to wonder just which one will be used in a situation where multiple contexts apply. Here's the order of evaluation.

* **arg[s]**
* **preview** *
* **test** *
* **simulator**
* **device**
* **debug** *
* **registered factory** (if any)
* **original factory**

Note that any context marked with an asterisk (*) is only available in a DEBUG build. The executable functionality is stripped from release builds.

## Global Context

Keep in mind that contexts are global. The entire app is running in debug more or it's not. It was passed a "mock0" argument at runtime or it wasn't. 

The `onArg` and `onDebug` and other context modifiers basically define how the app should respond to that particular context. 

## Changing a Context

Keep in mind that if we ever want to change a Factory's context but that Factory defines a scope, then we're also going to need to **manually** clear the scope cache for that object. 
```swift
Container.shared.myService
    .onTest { NullAnalyticsEngine() }
    .reset(.scope)
```
> Warning: With `reset` make sure you specify that you only want to clear the scope. Calling `reset` without a parameter clears everything, including contexts like the one you just set! 

See the section on *The Factory Wins* in <doc:Modifiers> for more information on this and other scenarios.
