//
//  CMHighScoreProtocol.swift
//  Colour Memory
//
//  Created by Bhupesh on 23/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

/// This is communication between View -> Presenter
protocol CMHighScoreViewToPresenterProtocol: AnyObject {
    
    var users: [CMUIProtocol]? {get set}
    
    var view: CMHighScorePresenterToViewProtocol? { get set }
    var interactor: CMHighScorePresenterToInteractorProtocol? { get set }
    var router: CMHighScorePresenterToRouterProtocol? { get set }
    
    func fetchUsers() // No pagination for now
    
}

/// This is communication between Presenter -> Interator.
protocol CMHighScorePresenterToInteractorProtocol: AnyObject {
    var presenter: CMHighScoreInteractorToPresenterProtocol? { get set }
    func fetchUsers()
}

/// All navigation related methods should go here.
protocol CMHighScorePresenterToRouterProtocol: AnyObject {
}

/// This is communication between Presenter -> View.
protocol CMHighScorePresenterToViewProtocol {
    func fetchedUsers(error: String)
}

/// This is communication between Interactor -> Presenter.
protocol CMHighScoreInteractorToPresenterProtocol: AnyObject {
    func fetchedUsers(users: [CMUIProtocol]?, error: String)
}

