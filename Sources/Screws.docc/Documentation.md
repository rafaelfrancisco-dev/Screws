# Screws Library

A comprehensive Swift utility library providing extensions, macros, and SwiftUI components to enhance your development workflow.

## Features

### DTO Generation

The library includes a powerful macro-based DTO (Data Transfer Object) generator that automatically creates DTOs from your class definitions.

```swift
@GenerateDTO(codable: false)
class YourClass {
    var property1: String
    var property2: Int
}
```

This generates a corresponding DTO struct with:
- All properties from the source class
- Initialization from the source class
- A method to copy back to the source class
- Optional Codable conformance

### Array Extensions

The library extends Array with useful functionality:

- `chunked(into:)`: Split arrays into equal-sized chunks
- `difference(from:)`: Calculate the symmetric difference between two arrays

### Date Extensions

Comprehensive date handling utilities:

- `dateFromDayAndMonth(day:month:)`: Create dates from day and month components
- `getDayInYear()`: Get the ordinal day in the year
- `get(_:calendar:)`: Extract specific calendar components
- Static month names retrieval

### Number Extensions

Enhanced number handling capabilities:

- Double formatting with decimal places
- Double rounding to specific decimal places
- Binary floating point extensions for whole and fractional parts extraction

### Device Information

The `Convenience` class provides cross-platform device metrics:

- Screen width and height
- Platform-specific implementations for iOS, macOS, and watchOS

### SwiftUI Components

A collection of SwiftUI view modifiers and utilities:

#### Frame Tracking
```swift
@available(iOS 17.0, macOS 14.0, watchOS 10.0, tvOS 17.0, visionOS 1.0, *)
Text("Example")
    .frameTracker(size: $viewSize)
```

#### View Extensions
- Conditional view modifications using `if`
- Horizontal and vertical content centering
- Frame size tracking

### Async/Await Utilities

Task extensions for better async/await handling:
- `Task.sleep(seconds:)`: Sleep for a specified duration in seconds

## Platform Support

- iOS 13.0+
- macOS 10.15+
- watchOS 6.0+
- tvOS 13.0+
- visionOS 1.0+

## Installation

[Add installation instructions here]

## Usage Examples

### DTO Generation
```swift
@GenerateDTO(codable: true)
class User {
    var name: String
    var age: Int
}

// Generated UserDTO can be used for data transfer
let user = User()
let dto = UserDTO(from: user)
```

### Array Chunking
```swift
let array = [1, 2, 3, 4, 5, 6, 7, 8]
let chunks = array.chunked(into: 3)
// Result: [[1, 2, 3], [4, 5, 6], [7, 8]]
```

### SwiftUI View Centering
```swift
Text("Centered Content")
    .centerContentsHorizontally()
    .centerContentsVertical()
```

## License

MIT License

Copyright (c) 2025 Rafael Francisco

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
