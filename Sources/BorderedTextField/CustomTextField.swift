//
//  CustomTextField.swift
//  BorderedTextField
//

import Foundation
import UIKit

public class CustomTextField: UITextField {
    var showBorderPlaceHolder:Bool = true  { didSet { self.setNeedsDisplay() } }
    public override var placeholder: String? { didSet { self.setNeedsDisplay() } }
    private var cornerRadius:CGFloat = 5.0  { didSet { self.setNeedsDisplay() } }
    var borderColor:UIColor = UIColor.gray  { didSet { self.setNeedsDisplay() } }
    var highlightColor:UIColor = UIColor.systemBlue  { didSet { self.setNeedsDisplay() } }
    var isEditingEnabled:Bool = true
    private let shoHidePasswordButton = UIButton(type: .custom)
    var isSecureField:Bool = false {
        didSet {
            self.isSecureTextEntry = isSecureField
            self.enablePasswordToggle()
        }
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.clear.setFill()
        self.isEnabled = isEditingEnabled
        let strokeColor = isEditing ? highlightColor : borderColor
        
        if showBorderPlaceHolder {
            UIRectFill(rect)
            let path = UIBezierPath()
            path.lineWidth = 1.0
            path.move(to: CGPoint(x: cornerRadius, y: 5))
            path.addLine(to: CGPoint(x: cornerRadius + 10, y: 5))
            
            let label = self.placeholder ?? ""
            let textFont = UIFont.boldSystemFont(ofSize: 10)
            
            let widthOfLabel:Double = 500.0
            let size = textFont.sizeOfString(string: label, constrainedToWidth: widthOfLabel)
            let textFontAttributes = [
                NSAttributedString.Key.font: textFont,
                NSAttributedString.Key.foregroundColor: strokeColor,
            ] as [NSAttributedString.Key : Any]
            label.draw(at: CGPoint(x:cornerRadius + 15, y:-2), withAttributes:textFontAttributes)
            
            path.move(to: CGPoint(x: size.width + cornerRadius + 20, y: 5))
            path.addLine(to: CGPoint(x: self.frame.width-2 - cornerRadius, y: 5))
            path.addQuadCurve(to: CGPoint(x: self.frame.width-2, y: 5 + cornerRadius), controlPoint: CGPoint(x: self.frame.width-2, y: 5))
            path.addLine(to: CGPoint(x: self.frame.width-2, y: self.frame.height-2-cornerRadius))
            path.addQuadCurve(to: CGPoint(x: self.frame.width-2-cornerRadius, y: self.frame.height-2), controlPoint: CGPoint(x: self.frame.width-2, y: self.frame.height-2))
            path.addLine(to: CGPoint(x: cornerRadius, y: self.frame.height-2))
            path.addQuadCurve(to: CGPoint(x: 1, y: self.frame.height-2-cornerRadius), controlPoint: CGPoint(x: 1, y: self.frame.height-2))
            path.addLine(to: CGPoint(x: 1, y: 5 + cornerRadius))
            path.addQuadCurve(to: CGPoint(x: cornerRadius, y: 5), controlPoint: CGPoint(x: 1, y: 5))
            
            strokeColor.set()
            path.stroke()
        }
        else {
            self.layer.cornerRadius = cornerRadius
            self.layer.borderColor = strokeColor.cgColor
            self.layer.borderWidth = 1
        }
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let inset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        return super.textRect(forBounds: bounds.inset(by: inset) )
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        return super.editingRect(forBounds: bounds.inset(by: inset))
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return super.rightViewRect(forBounds: bounds.inset(by: inset) )
    }
    
    func enablePasswordToggle() {
        guard self.isSecureField else { return }
        shoHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .selected)
        shoHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        shoHidePasswordButton.tintColor = .gray
        shoHidePasswordButton.addTarget(self, action: #selector(togglePasswordView(_:)), for: .touchUpInside)
        self.rightView = shoHidePasswordButton
        self.rightViewMode = .always
        shoHidePasswordButton.alpha = 0.4
    }
    
    @objc func togglePasswordView(_ sender: AnyObject?) {
        self.isSecureTextEntry.toggle()
        shoHidePasswordButton.isSelected.toggle()
    }
}
