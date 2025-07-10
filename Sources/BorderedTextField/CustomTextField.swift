//
//  CustomTextField.swift
//  BorderedTextField
//
//  Created by krishna.lolage
//

import Foundation
import UIKit

/// A custom UITextField that provides enhanced styling with bordered placeholders and secure text entry support.
///
/// This class extends UITextField to provide:
/// - Custom border drawing with placeholder text in the border
/// - Secure text entry with show/hide password toggle
/// - Customizable border and highlight colors
/// - Enhanced text insets for better visual appearance
public class CustomTextField: UITextField {
    
    // MARK: - Properties
    
    /// Whether to show the placeholder text in the border
    var showBorderPlaceHolder: Bool = true { 
        didSet { 
            setNeedsDisplay() 
        } 
    }
    
    /// Override to trigger redraw when placeholder changes
    public override var placeholder: String? { 
        didSet { 
            setNeedsDisplay() 
        } 
    }
    
    /// Corner radius for the border
    private var cornerRadius: CGFloat = 5.0 { 
        didSet { 
            setNeedsDisplay() 
        } 
    }
    
    /// Border color (used when not focused)
    var borderColor: UIColor = UIColor.gray { 
        didSet { 
            setNeedsDisplay() 
        } 
    }
    
    /// Highlight color (used when focused)
    var highlightColor: UIColor = UIColor.systemBlue { 
        didSet { 
            setNeedsDisplay() 
        } 
    }
    
    /// Whether editing is enabled
    var isEditingEnabled: Bool = true {
        didSet {
            isEnabled = isEditingEnabled
            setNeedsDisplay()
        }
    }
    
    /// Button for show/hide password functionality
    private let showHidePasswordButton = UIButton(type: .custom)
    
    /// Whether this is a secure text field (password field)
    var isSecureField: Bool = false {
        didSet {
            isSecureTextEntry = isSecureField
            enablePasswordToggle()
        }
    }
    
    // MARK: - Constants
    
    private struct Constants {
        static let textInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        static let rightViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        static let placeholderFontSize: CGFloat = 10
        static let placeholderYOffset: CGFloat = -2
        static let placeholderXOffset: CGFloat = 15
        static let placeholderPadding: CGFloat = 20
        static let borderWidth: CGFloat = 1.0
        static let buttonAlpha: CGFloat = 0.4
    }
    
    // MARK: - Drawing
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Clear the background
        UIColor.clear.setFill()
        UIRectFill(rect)
        
        // Ensure editing state is properly reflected
        isEnabled = isEditingEnabled
        
        // Determine stroke color based on editing state
        let strokeColor = isEditing ? highlightColor : borderColor
        
        if showBorderPlaceHolder {
            drawBorderedPlaceholder(in: rect, strokeColor: strokeColor)
        } else {
            drawSimpleBorder(strokeColor: strokeColor)
        }
    }
    
    // MARK: - Private Drawing Methods
    
    /// Draws the border with placeholder text integrated into the border
    private func drawBorderedPlaceholder(in rect: CGRect, strokeColor: UIColor) {
        let placeholderText = placeholder ?? ""
        let textFont = UIFont.boldSystemFont(ofSize: Constants.placeholderFontSize)
        
        // Calculate placeholder text size
        let placeholderSize = textFont.sizeOfString(
            string: placeholderText,
            constrainedToWidth: rect.width - Constants.placeholderPadding * 2
        )
        
        // Draw placeholder text
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: textFont,
            .foregroundColor: strokeColor
        ]
        
        let placeholderOrigin = CGPoint(
            x: cornerRadius + Constants.placeholderXOffset,
            y: Constants.placeholderYOffset
        )
        
        placeholderText.draw(at: placeholderOrigin, withAttributes: placeholderAttributes)
        
        // Draw border path with gap for placeholder
        let borderPath = createBorderPath(
            in: rect,
            placeholderWidth: placeholderSize.width,
            placeholderX: placeholderOrigin.x
        )
        
        strokeColor.setStroke()
        borderPath.lineWidth = Constants.borderWidth
        borderPath.stroke()
    }
    
    /// Creates the border path with a gap for the placeholder text
    private func createBorderPath(in rect: CGRect, placeholderWidth: CGFloat, placeholderX: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        
        // Top left to placeholder start
        path.move(to: CGPoint(x: cornerRadius, y: 5))
        path.addLine(to: CGPoint(x: placeholderX - 5, y: 5))
        
        // Skip placeholder area
        path.move(to: CGPoint(x: placeholderX + placeholderWidth + 5, y: 5))
        
        // Top right corner
        path.addLine(to: CGPoint(x: rect.width - 2 - cornerRadius, y: 5))
        path.addQuadCurve(
            to: CGPoint(x: rect.width - 2, y: 5 + cornerRadius),
            controlPoint: CGPoint(x: rect.width - 2, y: 5)
        )
        
        // Right side
        path.addLine(to: CGPoint(x: rect.width - 2, y: rect.height - 2 - cornerRadius))
        
        // Bottom right corner
        path.addQuadCurve(
            to: CGPoint(x: rect.width - 2 - cornerRadius, y: rect.height - 2),
            controlPoint: CGPoint(x: rect.width - 2, y: rect.height - 2)
        )
        
        // Bottom side
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height - 2))
        
        // Bottom left corner
        path.addQuadCurve(
            to: CGPoint(x: 1, y: rect.height - 2 - cornerRadius),
            controlPoint: CGPoint(x: 1, y: rect.height - 2)
        )
        
        // Left side
        path.addLine(to: CGPoint(x: 1, y: 5 + cornerRadius))
        
        // Top left corner
        path.addQuadCurve(
            to: CGPoint(x: cornerRadius, y: 5),
            controlPoint: CGPoint(x: 1, y: 5)
        )
        
        return path
    }
    
    /// Draws a simple border without placeholder integration
    private func drawSimpleBorder(strokeColor: UIColor) {
        layer.cornerRadius = cornerRadius
        layer.borderColor = strokeColor.cgColor
        layer.borderWidth = Constants.borderWidth
    }
    
    // MARK: - Layout Methods
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textInsets)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textInsets)
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return super.rightViewRect(forBounds: bounds.inset(by: Constants.rightViewInsets))
    }
    
    // MARK: - Password Toggle Methods
    
    /// Configures the password toggle button for secure text fields
    private func enablePasswordToggle() {
        guard isSecureField else { 
            rightView = nil
            rightViewMode = .never
            return 
        }
        
        configurePasswordButton()
        rightView = showHidePasswordButton
        rightViewMode = .always
    }
    
    /// Configures the appearance and behavior of the password toggle button
    private func configurePasswordButton() {
        // Configure button images
        showHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .selected)
        showHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        
        // Configure button appearance
        showHidePasswordButton.tintColor = .systemGray
        showHidePasswordButton.alpha = Constants.buttonAlpha
        
        // Add target for button tap
        showHidePasswordButton.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )
        
        // Set button size
        showHidePasswordButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    /// Toggles the visibility of the password text
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        showHidePasswordButton.isSelected.toggle()
        
        // Maintain cursor position after toggle
        if let existingText = text, isSecureTextEntry {
            deleteBackward()
            insertText(existingText)
        }
    }
}
