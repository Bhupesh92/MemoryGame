//
//  CMHighScoreRouter.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation

class CMHighScoreRouter: CMHighScorePresenterToRouterProtocol {
    static func createHighScoreModule() -> CMHighScoreController {
        CMOrientationManager.landscapeSupported = true
        let controller = CMHighScoreController(nibName: "CMHighScoreController", bundle: nil)
        let presenter: CMHighScoreViewToPresenterProtocol & CMHighScoreInteractorToPresenterProtocol = CMHighScorePresenter()
        let interactor: CMHighScorePresenterToInteractorProtocol = CMHighScoreInteractor()
        let router: CMHighScorePresenterToRouterProtocol = CMHighScoreRouter()
        controller.presenter = presenter as? CMHighScorePresenter
        presenter.view = controller
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return controller
    }
}
