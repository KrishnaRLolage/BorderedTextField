# BorderedTextField

A beautiful, customizable SwiftUI text field component with placeholder text elegantly positioned within the border.

[![Swift 5.9+](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![iOS 14.0+](https://img.shields.io/badge/iOS-14.0+-blue.svg)](https://developer.apple.com/ios/)
[![macCatalyst 14.0+](https://img.shields.io/badge/macCatalyst-14.0+-green.svg)](https://developer.apple.com/mac-catalyst/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

## Features

- 🎨 **Elegant Design**: Placeholder text integrated into the border for a modern look
- 🔐 **Secure Entry**: Built-in password field support with show/hide toggle
- 🎯 **Customizable**: Extensive customization options for colors, states, and behavior
- ♿ **Accessible**: Designed with accessibility in mind
- 📱 **Multi-platform**: Supports iOS and macCatalyst
- 🧪 **Well-tested**: Comprehensive test coverage

## Installation

### Swift Package Manager

Add BorderedTextField to your project using Swift Package Manager:

1. In Xcode, go to File → Add Package Dependencies
2. Enter the repository URL: `https://github.com/KrishnaRLolage/BorderedTextField.git`
3. Select the version you want to use
4. Click "Add Package"

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/KrishnaRLolage/BorderedTextField.git", from: "1.0.0")
]
```

## Usage

### Basic Usage

```swift
import SwiftUI
import BorderedTextField

struct ContentView: View {
    @State private var text = ""
    @State private var placeholder = "Enter your text"
    
    var body: some View {
        BorderedTextField(
            placeHolder: $placeholder,
            text: $text
        )
        .padding()
    }
}
```

### Advanced Usage

```swift
import SwiftUI
import BorderedTextField

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var usernamePlaceholder = "Username"
    @State private var passwordPlaceholder = "Password"
    
    var body: some View {
        VStack(spacing: 20) {
            // Regular text field
            BorderedTextField(
                placeHolder: $usernamePlaceholder,
                text: $username,
                borderColor: .gray,
                highlightColor: .blue
            )
            
            // Password field with custom colors
            BorderedTextField(
                placeHolder: $passwordPlaceholder,
                text: $password,
                isSecureField: true,
                borderColor: .gray,
                highlightColor: .green
            )
            
            // Disabled field
            BorderedTextField(
                placeHolder: .constant("Read-only field"),
                text: .constant("Cannot edit this"),
                isEditingEnabled: false,
                borderColor: .gray.opacity(0.5)
            )
        }
        .padding()
    }
}
```

## Configuration Options

### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `placeHolder` | `Binding<String>` | Required | Placeholder text displayed in the border |
| `text` | `Binding<String>` | Required | The text field's value |
| `isEditingEnabled` | `Bool` | `true` | Whether the text field is editable |
| `isSecureField` | `Bool` | `false` | Whether to use secure text entry (password field) |
| `showBorderPlaceHolder` | `Bool` | `true` | Whether to show placeholder in the border |
| `borderColor` | `Color` | `.gray` | Border color when not focused |
| `highlightColor` | `Color` | `.blue` | Border color when focused |

### Examples

```swift
// Basic editable field
BorderedTextField(placeHolder: $placeholder, text: $text)

// Non-editable field
BorderedTextField(
    placeHolder: $placeholder, 
    text: $text, 
    isEditingEnabled: false
)

// Password field
BorderedTextField(
    placeHolder: $placeholder, 
    text: $text, 
    isSecureField: true
)

// Custom colors
BorderedTextField(
    placeHolder: $placeholder,
    text: $text,
    borderColor: .red,
    highlightColor: .green
)

// Hidden placeholder (traditional border)
BorderedTextField(
    placeHolder: $placeholder,
    text: $text,
    showBorderPlaceHolder: false
)
```

## Demo

![BorderedTextField Demo](https://user-images.githubusercontent.com/21280198/157252118-05fa6d31-667b-4e38-bc46-0852b2a33917.gif)

## Requirements

- iOS 14.0+ / macCatalyst 14.0+
- Swift 5.9+
- Xcode 15.0+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

Krishna Lolage - [GitHub](https://github.com/KrishnaRLolage)

## Acknowledgments

- Thanks to the SwiftUI community for inspiration and feedback
- Special thanks to contributors who helped improve this package
