//
//  CustomTextField.swift
//  ScalingWaddle
//
//  Created by Amor on 25.02.2025.
//

import UIKit

class CustomTextField: UITextField {
    var bottomInset: CGFloat = 10.0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width, height: bounds.height - bottomInset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width, height: bounds.height - bottomInset)
    }
}
