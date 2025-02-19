//
//  MainModuleViewController.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Dependency
    
    var presenter: MainModulePresenterProtocol?
    
    
    // MARK: - UI Elements
    
    private lazy var dataTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DataTableViewCell.self, forCellReuseIdentifier: "DataCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.addSubview(dataTableView)
        setupConstraints()
    }
}


// MARK: - MainModuleViewControllerProtocol

extension MainViewController: MainModuleViewControllerProtocol {
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        return header
    }
}


// MARK: - Constraints

private
extension MainViewController {
    func setupConstraints() {
        dataTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dataTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dataTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dataTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dataTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
