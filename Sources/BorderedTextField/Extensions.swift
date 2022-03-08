//
//  Extensions.swift
//  BorderedTextField
//

import Foundation
import UIKit

internal extension UIFont {
  func sizeOfString(string: String, constrainedToWidth width: CGFloat) -> CGSize {
    return NSString(string: string).boundingRect(
      with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
      options: NSStringDrawingOptions.usesLineFragmentOrigin,
      attributes: [NSAttributedString.Key.font: self],
      context: nil
    ).size
  }
}

