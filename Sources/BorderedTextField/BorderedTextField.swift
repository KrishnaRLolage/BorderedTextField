//
//  BorderedTextField.swift
//  BorderedTextField
//
//  Created by krishna.lolage
//

import SwiftUI

/// A SwiftUI view that provides a customizable bordered text field with placeholder text displayed in the border.
///
/// `BorderedTextField` wraps a custom UITextField to provide enhanced styling options including:
/// - Placeholder text positioned in the border
/// - Customizable border and highlight colors
/// - Secure text entry support
/// - Editable/non-editable modes
///
/// ## Usage Example:
/// ```swift
/// @State private var text = ""
/// @State private var placeholder = "Enter text"
/// 
/// BorderedTextField(
///     placeHolder: $placeholder,
///     text: $text,
///     borderColor: .gray,
///     highlightColor: .blue
/// )
/// ```
public struct BorderedTextField: UIViewRepresentable {
    
    // MARK: - Properties
    
    @Binding private var textFieldPlaceholder: String
    @Binding private var fieldValue: String
    private let isEditingEnabled: Bool
    private let isSecureField: Bool
    private let showBorderPlaceHolder: Bool
    private let borderColor: UIColor
    private let highlightColor: UIColor
    
    // MARK: - Initialization
    
    /// Creates a new BorderedTextField with the specified configuration.
    ///
    /// - Parameters:
    ///   - placeHolder: A binding to the placeholder text
    ///   - text: A binding to the text field's value
    ///   - isEditingEnabled: Whether the text field is editable (default: true)
    ///   - isSecureField: Whether to use secure text entry (default: false)
    ///   - showBorderPlaceHolder: Whether to show placeholder in border (default: true)
    ///   - borderColor: The border color (default: gray)
    ///   - highlightColor: The highlight color when focused (default: blue)
    public init(
        placeHolder: Binding<String>,
        text: Binding<String>,
        isEditingEnabled: Bool = true,
        isSecureField: Bool = false,
        showBorderPlaceHolder: Bool = true,
        borderColor: Color = .gray,
        highlightColor: Color = .blue
    ) {
        self._textFieldPlaceholder = placeHolder
        self._fieldValue = text
        self.isEditingEnabled = isEditingEnabled
        self.isSecureField = isSecureField
        self.showBorderPlaceHolder = showBorderPlaceHolder
        self.borderColor = UIColor(borderColor)
        self.highlightColor = UIColor(highlightColor)
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: Context) -> CustomTextField {
        let customTextField = CustomTextField()
        
        // Configure basic properties
        customTextField.borderStyle = .none
        customTextField.isEditingEnabled = isEditingEnabled
        customTextField.isEnabled = isEditingEnabled
        customTextField.isSecureField = isSecureField
        customTextField.showBorderPlaceHolder = showBorderPlaceHolder
        customTextField.borderColor = borderColor
        customTextField.highlightColor = highlightColor
        customTextField.delegate = context.coordinator
        
        // Set initial values
        DispatchQueue.main.async {
            customTextField.text = fieldValue
            customTextField.placeholder = textFieldPlaceholder
        }
        
        return customTextField
    }
    
    public func updateUIView(_ customTextField: CustomTextField, context: Context) {
        // Update text and placeholder if they've changed
        if customTextField.text != fieldValue {
            customTextField.text = fieldValue
        }
        
        if customTextField.placeholder != textFieldPlaceholder {
            customTextField.placeholder = textFieldPlaceholder
        }
        
        // Configure layout constraints
        customTextField.setContentHuggingPriority(.required, for: .vertical)
        customTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(fieldValue: $fieldValue)
    }
}

// MARK: - Coordinator

extension BorderedTextField {
    /// Coordinator class to handle UITextFieldDelegate methods and manage text field state.
    public class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding private var fieldValue: String
        
        /// Initialize the coordinator with a binding to the text field value.
        /// - Parameter fieldValue: Binding to the text field's value
        init(fieldValue: Binding<String>) {
            self._fieldValue = fieldValue
            super.init()
        }
        
        // MARK: - UITextFieldDelegate
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Calculate the new text value
            guard let currentText = textField.text else { return true }
            let nsString = NSString(string: currentText)
            let newText = nsString.replacingCharacters(in: range, with: string)
            
            // Update the binding on the main queue
            DispatchQueue.main.async { [weak self] in
                self?.fieldValue = newText
            }
            
            return true
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            // Trigger a redraw to update the border color
            textField.setNeedsDisplay()
            
            // Update the binding with the final value
            DispatchQueue.main.async { [weak self] in
                self?.fieldValue = textField.text ?? ""
            }
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            // Trigger a redraw to update the border color to highlight color
            textField.setNeedsDisplay()
        }
    }
}
