//
//  DataCell.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

import UIKit

final class DataTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var nameTrailingConstraint: NSLayoutConstraint!
    private var ageTrailingConstraint: NSLayoutConstraint!
    private var removeButtonConstraints: [NSLayoutConstraint] = []
    
    
    // MARK: - UI Elements
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.attributedPlaceholder = NSAttributedString(string: "Имя",
                                                             attributes: [NSAttributedString.Key.baselineOffset : NSNumber(20)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .label
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(string: "Возраст",
                                                             attributes: [NSAttributedString.Key.baselineOffset : NSNumber(20)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(_ sectionType: SectionType) {
        //        nameTrailingConstraint.constant = sectionType == .main ? -16 : -160
        //        ageTrailingConstraint.constant = sectionType == .main ? -16 : -160
        if sectionType == .main {
            nameTrailingConstraint.constant = -16
            ageTrailingConstraint.constant = -16
            removeButton.isHidden = true
            NSLayoutConstraint.deactivate(removeButtonConstraints)
        } else {
            nameTrailingConstraint.constant = -160
            ageTrailingConstraint.constant = -160
            removeButton.isHidden = false
            NSLayoutConstraint.activate(removeButtonConstraints)
        }
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        contentView.addSubview(ageTextField)
        contentView.addSubview(nameTextField)
        contentView.addSubview(removeButton)
        setupConstraints()
    }
}


// MARK: - Constraints

private
extension DataTableViewCell {
    func setupConstraints() {
        nameTrailingConstraint = nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ageTrailingConstraint = ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        removeButtonConstraints = [removeButton.topAnchor.constraint(equalTo: nameTextField.topAnchor),
                                   removeButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 20),
                                   removeButton.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor)]
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTrailingConstraint,
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageTrailingConstraint,
            ageTextField.heightAnchor.constraint(equalToConstant: 60),
            ageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
