//
//  HeaderView.swift
//  ScalingWaddle
//
//  Created by Amor on 19.02.2025.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func childrenButtonTapped()
}

final class HeaderView: UIView {
    
    // MARK: - Dependency
    
    weak var delegate: MainViewControllerDelegate?
    
    
    // MARK: - UI Elements
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var addChildrenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("Добавить ребенка", for: .normal)
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.addTarget(self, action: #selector(addChildrenButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(_ sectionType: SectionType) {
        switch sectionType {
        case .main:
            headerLabel.text = "Персональные данные"
        case .child:
            headerLabel.text = "Дети (макс. 5)"
            addSubview(addChildrenButton)
            setupButtonConstraints()
        }
        
    }
    
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubview(headerLabel)
        setupConstraints()
    }
    
    
    // MARK: - Actions
    
    @objc
    private func addChildrenButtonTapped() {
        delegate?.childrenButtonTapped()
    }
}


// MARK: - Constraints

private
extension HeaderView {
    func setupConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
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
