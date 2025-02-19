//
//  DataCell.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

import UIKit

final class DataTableViewCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Имя",
                                                             attributes: [NSAttributedString.Key.baselineOffset : NSNumber(20)])
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "Возраст",
                                                             attributes: [NSAttributedString.Key.baselineOffset : NSNumber(20)])
        return textField
    }()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.addSubview(ageTextField)
        contentView.addSubview(nameTextField)
        setupConstraints()
    }
}


// MARK: - Constraints

private
extension DataTableViewCell {
    func setupConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ageTextField.heightAnchor.constraint(equalToConstant: 60),
            ageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
