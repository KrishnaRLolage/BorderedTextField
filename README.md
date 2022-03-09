# BorderedTextField
SwiftUI custom bordered text field with placeholder text in border.

### Usage: 
This control can be used in following different ways

```swift
BorderedTextField(placeHolder: .constant("TextField Editable"), text: $text)

BorderedTextField(placeHolder: .constant("TextField Non Editable"), text: $text, isEditingEnabled: false) 

BorderedTextField(placeHolder: .constant("Password Field"), text: $text, isSecureField: true)

BorderedTextField(placeHolder: .constant("Hide PlaceHolder"), text: $text, showBorderPlaceHolder: false, highlightColor: Color.green)

BorderedTextField(placeHolder: .constant("Change Border Color"), text: $text, borderColor: Color.red)

BorderedTextField(placeHolder: .constant("Focus Highlight Color "), text: $text, borderColor: Color.red, highlightColor: Color.green)
```

![Simulator Screen Recording - iPhone 13 Pro - 2022-03-08 at 19 03 06](https://user-images.githubusercontent.com/21280198/157252118-05fa6d31-667b-4e38-bc46-0852b2a33917.gif)


### Installation
Currently BorderedTextField is only avaliable via Swift Package Manager. You can also add manually to your project.

####  Swift Package Manager (SPM)
If you have already Swift package set up, add BorderedTextField as a dependency to your dependencies in your Package.swift file.

```swift
dependencies: [
    .package(url: "https://github.com/KrishnaRLolage/BorderedTextField.git")
]
```
