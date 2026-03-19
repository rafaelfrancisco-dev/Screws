# Screws

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frafaelfrancisco-dev%2FScrews%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/rafaelfrancisco-dev/Screws)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frafaelfrancisco-dev%2FScrews%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/rafaelfrancisco-dev/Screws)
[![](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A collection of useful Swift extensions, macros, and utilities to reduce boilerplate and improve productivity in your Swift projects.

## Features

- **GenerateDTO Macro** - Automatically generate Data Transfer Objects from your classes
- **SkipEncode Property Wrapper** - Skip encoding while still supporting decoding
- **Foundation Extensions** - Helpful extensions for `Date`, `Array`, `Double`, and more
- **Concurrency Utilities** - Task timeout helpers and sleep conveniences
- **SwiftUI Extensions** - Conditional view modifiers, content centering, and frame tracking
- **Cross-Platform Device Metrics** - Unified device dimension access across platforms

## Requirements

- iOS 12.0+ / macOS 10.15+ / watchOS 6.0+ / tvOS 13.0+ / visionOS 1.0+
- Swift 6.2+

## Installation

### Swift Package Manager

Add Screws to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/rafaelfrancisco-dev/Screws.git", from: "1.0.0")
]
```

Or add it directly in Xcode:
1. File → Add Packages...
2. Enter the repository URL: `https://github.com/rafaelfrancisco-dev/Screws.git`
3. Select the version you want to use

## Usage

### GenerateDTO Macro

Automatically generate a Data Transfer Object (DTO) from your classes:

```swift
import Screws

@GenerateDTO(codable: true)
class User {
    var name: String = ""
    var age: Int = 0
    var email: String = ""
}

// Usage
let user = User()
user.name = "John Doe"
user.age = 30
user.email = "john@example.com"

let dto = UserDTO(from: user)
let newUser = User()
dto.copyTo(newUser)
```

The generated DTO:
- Mirrors all properties from the source class
- Is always `Sendable` for safe concurrency
- Optionally conforms to `Codable` for serialization
- Includes initialization from source class
- Provides method to copy data back to source

### SkipEncode Property Wrapper

Skip encoding while still supporting decoding:

```swift
import Screws

struct Config: Codable {
    var name: String
    @SkipEncode var temporaryValue: String
}
```

### Foundation Extensions

#### Date Extensions

```swift
import Screws

let date = Date.dateFromDayAndMonth(day: 15, month: 3)
let dayInYear = date?.getDayInYear()
let month = date?.get(.month)
let months = Date.months()
```

#### Array Extensions

```swift
import Screws

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let chunks = numbers.chunked(into: 3)
// [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]]

let diff = [1, 2, 3].difference(from: [2, 3, 4])
// [1, 4]
```

#### Double Extensions

```swift
import Screws

let pi = 3.14159
let formatted = pi.format(f: 2.0)
let rounded = pi.rounded(toPlaces: 2)
```

### Concurrency Utilities

```swift
import Screws

Task {
    try await Task.sleep(seconds: 2.0)
}

let result = try await Task.withTimeout(duration: .seconds(5)) {
    try await someAsyncOperation()
}
```

### SwiftUI Extensions

```swift
import SwiftUI
import Screws

struct ContentView: View {
    @State private var frameSize: CGSize = .zero
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            Text("Hello")
                .if(showDetails) { view in
                    view.background(Color.blue)
                }
                .centerContentsHorizontally()
        }
        .frameTracker(size: $frameSize)
    }
}
```

### Cross-Platform Device Metrics

```swift
import Screws

let width = Convenience.deviceWidth
let height = Convenience.deviceHeight
```

## Documentation

Each feature includes comprehensive inline documentation. Option-click any symbol in Xcode to see detailed usage information.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Screws is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Author

Rafael Francisco
