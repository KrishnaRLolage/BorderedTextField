//
//  CustomTextFieldWrapper.swift
//  BorderedTextField
//
//  Created by krishna.lolage
//

import SwiftUI

public struct BorderedTextField: UIViewRepresentable {
    public init(placeHolder:Binding<String>, text:Binding<String>, isEditingEnabled: Bool = true, isSecureField: Bool = false, showBorderPlaceHolder: Bool = true, borderColor: Color = Color.gray, highlightColor: Color = Color.blue) {
        self._textFieldPlaceholder = placeHolder
        self._fieldValue = text
        self.isEditingEnabled = isEditingEnabled
        self.isSecureField = isSecureField
        self.showBorderPlaceHolder = showBorderPlaceHolder
        self.borderColor = UIColor(borderColor)
        self.highlightColor = UIColor(highlightColor)
    }
    
    @Binding private var textFieldPlaceholder:String
    @Binding private var fieldValue:String
    private var isEditingEnabled:Bool
    private var isSecureField:Bool = false
    private var showBorderPlaceHolder:Bool = true
    private var borderColor:UIColor = UIColor.gray
    private var highlightColor:UIColor = UIColor.gray
    
    public func makeUIView(context: Context) -> CustomTextField {
        
        let customTextField = CustomTextField()
        customTextField.borderStyle = .none
        DispatchQueue.main.async {
            customTextField.text = fieldValue
        }
        customTextField.isEditingEnabled = isEditingEnabled
        customTextField.isEnabled = isEditingEnabled
        customTextField.isSecureField = isSecureField
        customTextField.delegate = context.coordinator
        customTextField.showBorderPlaceHolder = showBorderPlaceHolder
        customTextField.borderColor = borderColor
        customTextField.highlightColor = highlightColor
        customTextField.placeholder = textFieldPlaceholder
        
        return customTextField
    }
    
    public func updateUIView(_ customTextField: CustomTextField, context: Context) {
        customTextField.placeholder = textFieldPlaceholder
        customTextField.text = fieldValue
        
        customTextField.setContentHuggingPriority(.required, for: .vertical)
        customTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(fieldValue:$fieldValue)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var fieldValue:String
        init(fieldValue:Binding<String>) {
            _fieldValue = fieldValue
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentValue = textField.text as NSString? {
                let proposedValue = currentValue.replacingCharacters(in: range, with: string)
                DispatchQueue.main.async { [self] in
                    fieldValue = proposedValue
                }
            }
            return true
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            textField.setNeedsDisplay()
            DispatchQueue.main.async { [self] in
                fieldValue = textField.text ?? ""
            }
        }
    }
}
