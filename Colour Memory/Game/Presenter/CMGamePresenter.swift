//
//  CMGamePresenter.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation

class CMGamePresenter: CMGameViewToPresenterProtocol {
    
    private var isShuffled = false
    
    private let freshData = [CMCardDetail(cardId: "colour1", image: "colour1"),
                              CMCardDetail(cardId: "colour2", image: "colour2"),
                              CMCardDetail(cardId: "colour3", image: "colour3"),
                         CMCardDetail(cardId: "colour4", image: "colour4"),
                              CMCardDetail(cardId: "colour5", image: "colour5"),
                              CMCardDetail(cardId: "colour6", image: "colour6"),
                         CMCardDetail(cardId: "colour7", image: "colour7"),
                              CMCardDetail(cardId: "colour8", image: "colour8"),
                              CMCardDetail(cardId: "colour1", image: "colour1"),
                              CMCardDetail(cardId: "colour2", image: "colour2"),
                              CMCardDetail(cardId: "colour3", image: "colour3"),
                         CMCardDetail(cardId: "colour4", image: "colour4"),
                              CMCardDetail(cardId: "colour5", image: "colour5"),
                              CMCardDetail(cardId: "colour6", image: "colour6"),
                         CMCardDetail(cardId: "colour7", image: "colour7"),
                              CMCardDetail(cardId: "colour8", image: "colour8")]
    
    lazy var cards: [CMCardDetail] = freshData
    
    var totalScore: Int16 = 0
    
    var flipPair: Int = 0 {
        didSet {
            if flipPair >= CMConstant.maxPair {
                // Game Over, Send messge to View
                self.view?.gameOver()
            }
        }
    }
    
    var lockedIds = [String]()
    
    var flippedCardsDetails: [(card: CMCardDetail, indexPath: IndexPath)]? {
        didSet {
            if flippedCardsDetails?.count ?? -1 >= 2 {
                let faceUpcards = flippedCardsDetails!.filter { cardInfo in
                    return cardInfo.card.isFaceUp
                }
                
                if faceUpcards.count >= 2 {
                    // Freeze user activity for 0.5*2 sec
                    self.view?.disableUser(for: CMConstant.throttle)
                    if faceUpcards.first?.card.cardId == faceUpcards.last?.card.cardId {
                        // Increase score by 2 pts and tell view to disable interaction of those cards
                        lockedIds.append(faceUpcards.first?.card.cardId ?? "")
                        lockedIds.append(faceUpcards.last?.card.cardId ?? "")
                        flipPair += 1
                        self.totalScore += 2
                    } else {
                        guard let ip1 = faceUpcards.first?.indexPath, let ip2 = faceUpcards.last?.indexPath else {
                            return
                        }
                        // Decrease score by -1 pts, flip selected cards again
                        self.totalScore -= 1
                        var firstCard = self.cards[ip1.row]
                        firstCard.isFaceUp = false
                        self.cards[ip1.row] = firstCard
                        var lastCard = self.cards[ip2.row]
                        lastCard.isFaceUp = false
                        self.cards[ip2.row] = lastCard
                        self.view?.flipCards(indexPaths: [ip1, ip2])
                    }
                }
                flippedCardsDetails = nil
            }
        }
    }
    
    var view: CMGamePresenterToViewProtocol?
    
    var interactor: CMGamePresenterToInteractorProtocol?
    
    var router: CMGamePresenterToRouterProtocol?
    
    func navigateToHighScoreController() {
        guard let controller = self.view as? CMGameController else {
            return
        }
        self.router?.navigateToHighScoreController(base: controller)
    }
    
    func getTotalScore() -> String {
        return "\(totalScore)"
    }
    
    func isCardLocked(id: String) -> Bool {
        return self.lockedIds.contains(id)
    }
    
    func getShuffledCards() -> [CMCardDetail] {
        if isShuffled {
            return self.cards
        }
        isShuffled = true
        self.cards = self.cards.shuffled()
        return self.cards
    }
    
    func updateCardDetail(at indexPath: IndexPath, isFaceUp: Bool) {
        var card = self.cards[indexPath.row]
        card.isFaceUp = isFaceUp
        self.cards[indexPath.row] = card
        if isFaceUp {
            if flippedCardsDetails?.count ?? -1 > 0 {
                flippedCardsDetails?.append((card, indexPath: indexPath))
            } else {
                flippedCardsDetails = [(card, indexPath: indexPath)]
            }
        }
    }
    
    func restartGame() {
        isShuffled = false
        totalScore = 0
        flipPair = 0
        lockedIds.removeAll()
        flippedCardsDetails = nil
        cards = freshData
    }
}

extension CMGamePresenter: CMGameInteractorToPresenterProtocol {
    
}
