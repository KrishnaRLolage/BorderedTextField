//
//  Extensions.swift
//  BorderedTextField
//
//  Created by krishna.lolage
//

import Foundation
import UIKit

// MARK: - UIFont Extensions

internal extension UIFont {
    /// Calculates the size of a string when rendered with this font, constrained to a specific width.
    ///
    /// This method is useful for determining how much space a text string will occupy
    /// when rendered with the current font, which is essential for proper layout calculations.
    ///
    /// - Parameters:
    ///   - string: The text string to measure
    ///   - width: The maximum width constraint for the text
    /// - Returns: A CGSize representing the dimensions the text will occupy
    func sizeOfString(string: String, constrainedToWidth width: CGFloat) -> CGSize {
        guard !string.isEmpty else {
            // Return size with zero width but font height for empty strings
            return CGSize(width: 0, height: lineHeight)
        }
        
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let attributes = [NSAttributedString.Key.font: self]
        
        let boundingRect = NSString(string: string).boundingRect(
            with: constraintRect,
            options: options,
            attributes: attributes,
            context: nil
        )
        
        // Return ceiling values to ensure we don't truncate text
        return CGSize(
            width: ceil(boundingRect.width),
            height: ceil(boundingRect.height)
        )
    }
}

// MARK: - UIColor Extensions

internal extension UIColor {
    /// Creates a lighter version of the current color by adjusting its brightness.
    ///
    /// - Parameter factor: The factor by which to lighten the color (0.0 to 1.0)
    /// - Returns: A new UIColor that is lighter than the original
    func lighter(by factor: CGFloat = 0.2) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newBrightness = min(brightness + factor, 1.0)
            return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
        }
        
        return self
    }
    
    /// Creates a darker version of the current color by adjusting its brightness.
    ///
    /// - Parameter factor: The factor by which to darken the color (0.0 to 1.0)
    /// - Returns: A new UIColor that is darker than the original
    func darker(by factor: CGFloat = 0.2) -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let newBrightness = max(brightness - factor, 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: newBrightness, alpha: alpha)
        }
        
        return self
    }
}

