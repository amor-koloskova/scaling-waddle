//
//  DataCell.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

protocol CellDelegate: AnyObject {
    func textDidBeginEditing(in cell: DataTableViewCell, for textField: UITextField)
}

import UIKit

final class DataTableViewCell: UITableViewCell {
    
    // MARK: - Dependency
    
    weak var delegate: CellDelegate?    
     
    // MARK: - Private Properties
    
    private var nameTextFieldTrailingConstraint: NSLayoutConstraint!
    private var ageTextFieldTrailingConstraint: NSLayoutConstraint!
    private var removeButtonConstraints: [NSLayoutConstraint] = []
    private var userType: UserType = .adult
    
    
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
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
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
    
    func configure(_ userType: UserType, with userModel: UserModel, target: Any?, action: Selector) {
        self.userType = userModel.type
        nameTextField.text = userModel.name
        ageTextField.text = userModel.age
        nameTextField.addTarget(target, action: action, for: .editingChanged)
        ageTextField.addTarget(target, action: action, for: .editingChanged)
        if userType == .adult {
            nameTextFieldTrailingConstraint.constant = -16
            ageTextFieldTrailingConstraint.constant = -16
            removeButton.isHidden = true
            NSLayoutConstraint.deactivate(removeButtonConstraints)
        } else {
            nameTextFieldTrailingConstraint.constant = -160
            ageTextFieldTrailingConstraint.constant = -160
            removeButton.isHidden = false
            NSLayoutConstraint.activate(removeButtonConstraints)
        }
    }
    
    
    // MARK: - Internal methods
    
    func getUpdatedUserData() -> UserModel {
        UserModel(name: nameTextField.text, age: ageTextField.text, type: userType)
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(ageTextField)
        contentView.addSubview(nameTextField)
        contentView.addSubview(removeButton)
        setupConstraints()
        setupTextFields()
    }
    
    private func setupTextFields() {
        nameTextField.delegate = self
        ageTextField.delegate = self
    }
    
    
    // MARK: - Actions / Closures
    
    @objc
    private func removeButtonTapped() {
        removeButtonAction?()
    }
    
    var removeButtonAction: (() -> Void)?
}


// MARK: - UITextFieldDelegate

extension DataTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textDidBeginEditing(in: self, for: textField)
    }
}


// MARK: - Constraints

private
extension DataTableViewCell {
    func setupConstraints() {
        nameTextFieldTrailingConstraint = nameTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ageTextFieldTrailingConstraint = ageTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        removeButtonConstraints = [removeButton.topAnchor.constraint(equalTo: nameTextField.topAnchor),
                                   removeButton.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 20),
                                   removeButton.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor)]
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameTextFieldTrailingConstraint,
            nameTextField.heightAnchor.constraint(equalToConstant: 60),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            ageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ageTextFieldTrailingConstraint,
            ageTextField.heightAnchor.constraint(equalToConstant: 60),
            ageTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
