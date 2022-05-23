//
//  CMGameProtocol.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit
/// This is communication between View -> Presenter
protocol CMGameViewToPresenterProtocol: AnyObject {
    
    var flipPair: Int {get set}
    var flippedCardsDetails: [(card: CMCardDetail, indexPath: IndexPath)]? {get set}
    var lockedIds: [String] {get set}
    var totalScore: Int16 {get set}
    var cards: [CMCardDetail] {get set}
    

    var view: CMGamePresenterToViewProtocol? { get set }
    var interactor: CMGamePresenterToInteractorProtocol? { get set }
    var router: CMGamePresenterToRouterProtocol? { get set }
    
    func navigateToHighScoreController()
    func getTotalScore() -> String
    func isCardLocked(id: String) -> Bool
    func getShuffledCards() -> [CMCardDetail]
    func updateCardDetail(at indexPath: IndexPath, isFaceUp: Bool)
    func restartGame()
}

/// This is communication between Presenter -> Interator.
protocol CMGamePresenterToInteractorProtocol: AnyObject {
    var presenter: CMGameInteractorToPresenterProtocol? { get set }
}

/// All navigation related methods should go here.
protocol CMGamePresenterToRouterProtocol: AnyObject {
    func navigateToHighScoreController(base: CMGameController)
}

/// This is communication between Presenter -> View.
protocol CMGamePresenterToViewProtocol {
    func gameOver()
    func disableUser(for duration: TimeInterval)
    func flipCards(indexPaths: [IndexPath])
}

/// This is communication between Interactor -> Presenter.
protocol CMGameInteractorToPresenterProtocol: AnyObject {
}
