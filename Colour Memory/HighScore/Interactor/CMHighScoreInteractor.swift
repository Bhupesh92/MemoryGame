//
//  CMHighScoreInteractor.swift
//  Colour Memory
//
//  Created by Bhupesh on 23/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation

class CMHighScoreInteractor: CMHighScorePresenterToInteractorProtocol {
    
    var presenter: CMHighScoreInteractorToPresenterProtocol?
    
    func fetchUsers() {
        let manager = CMDBManager.shared
        DispatchQueue.Bhupesh(qos: .userInitiated).async {
            let result = manager.fetchUsers()
            self.presenter?.fetchedUsers(users: result, error: result?.count ?? -1 < 1 ? "No Users found": "")
        }
    }
}
