// 
//  MainModuleBuilder.swift
//  ScalingWaddle
//
//  Created by Amor on 18.02.2025.
//

import UIKit

final class MainModuleBuilder {
    static func createMainModuleModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainModulePresenter(view: view)
        view.presenter = presenter
        return view
    }
}
