//
//  CMHighScorePresenter.swift
//  Colour Memory
//
//  Created by Bhupesh on 23/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation

class CMHighScorePresenter: CMHighScoreViewToPresenterProtocol {
    
    var users: [CMUIProtocol]?
    
    var view: CMHighScorePresenterToViewProtocol?
    
    var interactor: CMHighScorePresenterToInteractorProtocol?
    
    var router: CMHighScorePresenterToRouterProtocol?
    
    func fetchUsers() {
        self.interactor?.fetchUsers()
    }
}

extension CMHighScorePresenter: CMHighScoreInteractorToPresenterProtocol {
    func fetchedUsers(users: [CMUIProtocol]?, error: String) {
        self.users = users
        self.view?.fetchedUsers(error: error)
    }
}
