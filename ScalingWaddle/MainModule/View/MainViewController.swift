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
    
    
    // MARK: Private properties
    
    private let sectionType = UserType.allCases
    
    
    // MARK: - UI Elements
    
    private lazy var dataTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DataTableViewCell.self, forCellReuseIdentifier: "DataCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardObservers()
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(dataTableView)
        setupConstraints()
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    // MARK: - Actions
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,/*,  else { return }*/
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let animationCurveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
              let animationCurve = UIView.AnimationCurve(rawValue: animationCurveRaw) else { return }
        presenter?.keyboardWillShow(keyboardHeight: keyboardFrame.height, duration: duration, animationCurve: animationCurve)
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        presenter?.keyboardWillHide()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let cell = textField.superview?.superview as? DataTableViewCell,
              let indexPath = dataTableView.indexPath(for: cell) else { return }
        let updatedData = cell.getUpdatedUserData()
        presenter?.updateUserData(at: indexPath, name: updatedData.name, age: updatedData.age)
    }
}


// MARK: - MainModuleViewControllerProtocol

extension MainViewController: MainModuleViewControllerProtocol {
    func adjustTableViewForKeyboard(keyboardHeight: CGFloat,
                                    activeTextFieldFrame: CGRect,
                                    duration: TimeInterval,
                                    animationCurve: UIView.AnimationCurve) {
        let visibleAreaHeight = view.frame.height - keyboardHeight
        let textFieldBottom = activeTextFieldFrame.origin.y + activeTextFieldFrame.height * 1.5
        let offset = textFieldBottom - visibleAreaHeight
        if offset > 0 {
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            dataTableView.contentInset = contentInset
            dataTableView.verticalScrollIndicatorInsets = contentInset
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIView.AnimationOptions(rawValue: UInt(animationCurve.rawValue << 16)),
                           animations: {
                self.dataTableView.contentOffset.y += offset
            }, completion: nil)
        }
    }
    
    func resetTableViewInsets() {
        UIView.animate(withDuration: 0.3) {
            self.dataTableView.contentInset = .zero
            self.dataTableView.scrollIndicatorInsets = .zero
        }
    }
    
    func reloadTableView() {
        dataTableView.reloadData()
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Настройки",
                                            message: "Пожалуйста, выберите опцию",
                                            preferredStyle: .actionSheet)
        let clearAction = UIAlertAction(title: "Сбросить данные",
                                        style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.presenter?.clearAllData()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        actionSheet.addAction(clearAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true)
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return 0 }
        return presenter.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let presenter else { return 0 }
        return presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DataCell", for: indexPath) as? DataTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        let userData = presenter?.userData(at: indexPath)
        cell.configure(sectionType[indexPath.section], with: userData ?? UserModel(name: nil, age: nil, type: .adult),
                       target: self,
                       action: #selector(textFieldDidChange(_:)))
        cell.removeButtonAction = { [weak self] in
            self?.presenter?.removeButtonPressed(at: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderView()
        header.configure(userType: sectionType[section], childrenCount: presenter?.getChildrenDataSource().count ?? 0)
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = FooterView()
        footer.delegate = self
        return sectionType[section] == .child ? footer :  nil
    }
}


// MARK: - HeaderViewDelegate

extension MainViewController: HeaderViewDelegate {
    func didTapChildrenButton() {
        presenter?.addChildButtonPressed()
    }
}


// MARK: - FooterViewDelegate

extension MainViewController: FooterViewDelegate {
    func didTapClearButton() {
        presenter?.clearButtonPressed()
    }
}


// MARK: - CellDelegate

extension MainViewController: CellDelegate {
    func textDidBeginEditing(in cell: DataTableViewCell, for textField: UITextField) {
        presenter?.textFieldDidBeginEditing(cell: cell, textField: textField)
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
            dataTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
