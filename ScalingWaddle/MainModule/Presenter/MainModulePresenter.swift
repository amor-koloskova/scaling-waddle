// 
//  MainModulePresenter.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

import Foundation

protocol MainModuleViewControllerProtocol: AnyObject {
    
}

protocol MainModulePresenterProtocol {
    
}

final class MainModulePresenter {
    
    // MARK: - Private properties
    
    private weak var view: MainModuleViewControllerProtocol?
    
    
    // MARK: - Lifecycle
    
    init(view: MainModuleViewControllerProtocol) {
        self.view = view
    }
}

// MARK: - MainModulePresenterProtocol

extension MainModulePresenter: MainModulePresenterProtocol {
    
}
