//
//  HeaderView.swift
//  ScalingWaddle
//
//  Created by Amor on 19.02.2025.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func didTapChildrenButton()
}

final class HeaderView: UIView {
    
    // MARK: - Dependency
    
    weak var delegate: HeaderViewDelegate?
    
    
    // MARK: - UI Elements
    
    private let titleHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var addChildrenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("Добавить ребенка", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(addChildrenButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(userType: UserType, childrenCount: Int) {
        switch userType {
        case .adult:
            titleHeaderLabel.text = "Персональные данные"
        case .child:
            titleHeaderLabel.text = "Дети (макс. 5)"
            addSubview(addChildrenButton)
            if childrenCount >= 5 {
                addChildrenButton.isHidden = true
            }
            setupButtonConstraints()
        }
        
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .systemBackground
        addSubview(titleHeaderLabel)
        setupConstraints()
    }
    
    
    // MARK: - Actions
    
    @objc
    private func addChildrenButtonTapped() {
        delegate?.didTapChildrenButton()
    }
}


// MARK: - Constraints

private
extension HeaderView {
    func setupConstraints() {
        titleHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleHeaderLabel.topAnchor.constraint(equalTo: topAnchor),
            titleHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleHeaderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupButtonConstraints() {
        addChildrenButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addChildrenButton.heightAnchor.constraint(equalToConstant: 44),
            addChildrenButton.widthAnchor.constraint(equalToConstant: 192),
            addChildrenButton.topAnchor.constraint(equalTo: topAnchor),
            addChildrenButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addChildrenButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
