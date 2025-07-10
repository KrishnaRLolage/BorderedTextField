import XCTest
import SwiftUI
@testable import BorderedTextField

final class BorderedTextFieldTests: XCTestCase {
    
    // MARK: - BorderedTextField Tests
    
    func testBorderedTextFieldInitialization() throws {
        let placeholder = "Test Placeholder"
        let text = "Test Text"
        let placeholderBinding = Binding.constant(placeholder)
        let textBinding = Binding.constant(text)
        
        let textField = BorderedTextField(
            placeHolder: placeholderBinding,
            text: textBinding,
            isEditingEnabled: true,
            isSecureField: false,
            showBorderPlaceHolder: true,
            borderColor: .gray,
            highlightColor: .blue
        )
        
        XCTAssertNotNil(textField)
    }
    
    func testBorderedTextFieldSecureFieldInitialization() throws {
        let placeholder = "Password"
        let text = ""
        let placeholderBinding = Binding.constant(placeholder)
        let textBinding = Binding.constant(text)
        
        let secureTextField = BorderedTextField(
            placeHolder: placeholderBinding,
            text: textBinding,
            isSecureField: true
        )
        
        XCTAssertNotNil(secureTextField)
    }
    
    // MARK: - CustomTextField Tests
    
    func testCustomTextFieldDefaultValues() throws {
        let customTextField = CustomTextField()
        
        XCTAssertTrue(customTextField.showBorderPlaceHolder)
        XCTAssertTrue(customTextField.isEditingEnabled)
        XCTAssertFalse(customTextField.isSecureField)
        XCTAssertEqual(customTextField.borderColor, UIColor.gray)
        XCTAssertEqual(customTextField.highlightColor, UIColor.systemBlue)
    }
    
    func testCustomTextFieldSecureFieldToggle() throws {
        let customTextField = CustomTextField()
        
        // Test initial state
        XCTAssertFalse(customTextField.isSecureField)
        XCTAssertFalse(customTextField.isSecureTextEntry)
        
        // Test enabling secure field
        customTextField.isSecureField = true
        XCTAssertTrue(customTextField.isSecureField)
        XCTAssertTrue(customTextField.isSecureTextEntry)
        
        // Test disabling secure field
        customTextField.isSecureField = false
        XCTAssertFalse(customTextField.isSecureField)
        XCTAssertFalse(customTextField.isSecureTextEntry)
    }
    
    func testCustomTextFieldEditingState() throws {
        let customTextField = CustomTextField()
        
        // Test default enabled state
        XCTAssertTrue(customTextField.isEditingEnabled)
        XCTAssertTrue(customTextField.isEnabled)
        
        // Test disabling editing
        customTextField.isEditingEnabled = false
        XCTAssertFalse(customTextField.isEditingEnabled)
    }
    
    // MARK: - Extensions Tests
    
    func testUIFontSizeOfString() throws {
        let font = UIFont.systemFont(ofSize: 16)
        let testString = "Test String"
        let constrainedWidth: CGFloat = 200
        
        let size = font.sizeOfString(string: testString, constrainedToWidth: constrainedWidth)
        
        XCTAssertGreaterThan(size.width, 0)
        XCTAssertGreaterThan(size.height, 0)
        XCTAssertLessThanOrEqual(size.width, constrainedWidth)
    }
    
    func testUIFontSizeOfStringWithEmptyString() throws {
        let font = UIFont.systemFont(ofSize: 16)
        let emptyString = ""
        let constrainedWidth: CGFloat = 200
        
        let size = font.sizeOfString(string: emptyString, constrainedToWidth: constrainedWidth)
        
        XCTAssertEqual(size.width, 0)
        XCTAssertGreaterThan(size.height, 0) // Height should still be present due to font metrics
    }
}
