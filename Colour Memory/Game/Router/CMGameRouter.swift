//
//  CMGameRouter.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation
import UIKit

class CMGameRouter: CMGamePresenterToRouterProtocol {
    
    func navigateToHighScoreController(base: CMGameController) {
        base.navigationController?.pushViewController(CMHighScoreRouter.createHighScoreModule(), animated: true)
    }
    
    static func createGameModule() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let navigationController = storyboard.instantiateViewController(withIdentifier: "CMGameNavigationController") as?
            UINavigationController,
            let controller = navigationController.viewControllers.first as?
            CMGameController {
            let presenter: CMGameViewToPresenterProtocol & CMGameInteractorToPresenterProtocol = CMGamePresenter()
            let interactor: CMGamePresenterToInteractorProtocol = CMGameInteractor()
            let router: CMGamePresenterToRouterProtocol = CMGameRouter()
            controller.presenter = presenter as? CMGamePresenter
            presenter.view = controller
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            return navigationController
        }
        return UINavigationController()
    }
}
