//
//  MainModulePresenter.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

import Foundation
import UIKit

protocol MainModuleViewControllerProtocol: AnyObject {
    func reloadTableView()
    func showActionSheet()
    func adjustTableViewForKeyboard(keyboardHeight: CGFloat,
                                    activeTextFieldFrame: CGRect,
                                    duration: TimeInterval,
                                    animationCurve: UIView.AnimationCurve)
    func resetTableViewInsets()
}

protocol MainModulePresenterProtocol {
    var numberOfSections: Int { get }
    func numberOfRows(in section: Int) -> Int
    func userData(at indexPath: IndexPath) -> UserModel
    func updateUserData(at indexPath: IndexPath, name: String?, age: String?)
    func getChildrenDataSource() -> [UserModel]
    func addChildButtonPressed()
    func clearButtonPressed()
    func removeButtonPressed(at indexPath: IndexPath)
    func clearAllData()
    func textFieldDidBeginEditing(cell: DataTableViewCell, textField: UITextField)
    func keyboardWillShow(keyboardHeight: CGFloat, duration: TimeInterval, animationCurve: UIView.AnimationCurve)
    func keyboardWillHide()
}

final class MainModulePresenter {
    
    // MARK: - Internal Properties
    
    var numberOfSections: Int {
        return UserType.allCases.count
    }
    
    
    // MARK: - Private properties
    
    private weak var view: MainModuleViewControllerProtocol?
    private var activeTextFieldFrame: CGRect?
    private var adultDataSource: [UserModel] = [UserModel(name: nil, age: nil, type: .adult)]
    private var childrenDataSource: [UserModel] = []
    
    
    // MARK: - Lifecycle
    
    init(view: MainModuleViewControllerProtocol) {
        self.view = view
    }
}


// MARK: - MainModulePresenterProtocol

extension MainModulePresenter: MainModulePresenterProtocol {
    
    func numberOfRows(in section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return childrenDataSource.count
        }
    }
    
    func userData(at indexPath: IndexPath) -> UserModel {
        if indexPath.section == 0 {
            return adultDataSource[indexPath.row]
        } else {
            return childrenDataSource[indexPath.row]
        }
    }
    
    func updateUserData(at indexPath: IndexPath, name: String?, age: String?) {
        if indexPath.section == 0 {
            adultDataSource[indexPath.row] = UserModel(name: name ?? "", age: age ?? "", type: .adult)
        } else {
            childrenDataSource[indexPath.row] = UserModel(name: name ?? "", age: age ?? "", type: .child)
        }
    }
    
    func getChildrenDataSource() -> [UserModel] {
        childrenDataSource
    }
    
    func addChildButtonPressed() {
        if childrenDataSource.count < 5 {
            childrenDataSource.append(UserModel(name: nil, age: nil, type: .child))
            view?.reloadTableView()
        }
    }
    
    func clearButtonPressed() {
        view?.showActionSheet()
    }
    
    func removeButtonPressed(at indexPath: IndexPath) {
        childrenDataSource.remove(at: indexPath.row)
        view?.reloadTableView()
    }
    
    func clearAllData() {
        adultDataSource = [UserModel(name: nil, age: nil, type: .adult)]
        childrenDataSource.removeAll()
        view?.reloadTableView()
    }
    
    func textFieldDidBeginEditing(cell: DataTableViewCell, textField: UITextField) {
        let textFieldFrame = cell.convert(textField.frame, to: nil)
        activeTextFieldFrame = textFieldFrame
    }
    
    func keyboardWillShow(keyboardHeight: CGFloat, duration: TimeInterval, animationCurve: UIView.AnimationCurve) {
        guard let activeFrame = activeTextFieldFrame else { return }
        view?.adjustTableViewForKeyboard(keyboardHeight: keyboardHeight,
                                         activeTextFieldFrame: activeFrame,
                                         duration: duration,
                                         animationCurve: animationCurve)
    }
    
    func keyboardWillHide() {
        view?.resetTableViewInsets()
    }
}
