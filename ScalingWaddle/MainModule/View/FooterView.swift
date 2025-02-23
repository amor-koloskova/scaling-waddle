//
//  FooterView.swift
//  ScalingWaddle
//
//  Created by Amor on 23.02.2025.
//
import UIKit

final class FooterView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
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
    
    
    // MARK: - Private Methods
    
    private func setup() {
        addSubview(clearButton)
        setupConstraints()
    }
    
    // MARK: - Actions
    
    
    @objc
    private func clearButtonTapped() {
        
    }
}


// MARK: - Constraints
private
extension FooterView {
    func setupConstraints() {
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.heightAnchor.constraint(equalToConstant: 44),
            clearButton.widthAnchor.constraint(equalToConstant: 192),
            clearButton.topAnchor.constraint(equalTo: topAnchor),
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
}
