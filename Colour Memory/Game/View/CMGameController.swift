//
//  CMGameController.swift
//  Colour Memory
//
//  Created by Bhupesh on 18/05/22.
//

import UIKit

class CMGameController: UIViewController {
    
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: CMGameViewToPresenterProtocol?
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initalSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CMOrientationManager.forceRotateToPotraitScapeDevice()
    }
    
    // MARK: setup
    private func initalSetup() {
        collectionView.register(UINib(nibName: CMConstant.Identifier.cmCard, bundle: nil), forCellWithReuseIdentifier: CMConstant.Identifier.cmCard)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: High score button action
    @IBAction func highScoreDidTapped(_ sender: UIButton) {
        presenter?.navigateToHighScoreController()
    }
}

// MARK: UICollectionViewDelegate
extension CMGameController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.getShuffledCards().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CMConstant.Identifier.cmCard,
                                                      for: indexPath)
        if let card = self.presenter?.getShuffledCards()[indexPath.row] {
            (cell as? CMCard)?.updateCard(animation: card.isFaceUp ? CMFlipAnimation.open: .close, image: card.isFaceUp ? card.image: "card_bg" )
            
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CMGameController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if var card = self.presenter?.getShuffledCards()[indexPath.row] {
            
            if card.isFaceUp == true && self.presenter?.flippedCardsDetails?.count ?? -1 < 2 {
                return
            }
            
            card.isFaceUp = !card.isFaceUp
            
            if self.presenter?.isCardLocked(id: card.cardId) ?? false {
                return
            }
            
            
            if let cell = collectionView.cellForItem(at: indexPath) as? CMCard {
                cell.updateCard(animation: card.isFaceUp ? CMFlipAnimation.open: .close, image: card.isFaceUp ? card.image: "card_bg" )
            }
            
            self.presenter?.updateCardDetail(at: indexPath, isFaceUp: card.isFaceUp)

            self.currentScoreLabel.text = """
                                             Your Score:
                                             \(self.presenter?.getTotalScore() ?? "0")
                                             """
        }
        self.disableUser(for: CMConstant.throttle)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CMGameController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CMConstant.calculateCardSize(for: collectionView.frame.size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CMConstant.Card.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CMConstant.Card.lineSpacing
    }
}

// MARK: - CMGamePresenterToViewProtocol
extension CMGameController: CMGamePresenterToViewProtocol {
    
    func flipCards(indexPaths: [IndexPath]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + CMConstant.throttle) { [unowned self] in
            for indexPath in indexPaths {
                if let cell = self.collectionView.cellForItem(at: indexPath) as? CMCard  {
                    cell.updateCard(animation: CMFlipAnimation.close, image: "card_bg" )
                }
            }
        }
    }
    
    func gameOver() {
        
        func refreshGame() {
            self.presenter?.restartGame()
            self.currentScoreLabel.text = """
                                             Your Score:
                                             \(self.presenter?.getTotalScore() ?? "0")
                                             """
            self.collectionView.reloadData()
        }
        
        let message = "User id should be unique and should not contain any space. User name should not exceed than 16 characters."
        showAlert(title: "Enter user id", message: message)
        
        func showAlert(title: String, message: String, textFieldNeed: Bool = true) {
            CMAlert(title: title, message: message, textFieldNeed: textFieldNeed).showAlert(base: self) { inputText in
                if textFieldNeed == false {
                    return
                }
                let validationResult = CMValidationManager.isValidUserId(userId: inputText)
                if validationResult.isValid {
                    // Validate from core data if fail, show alert "UserId exists already" else save into db and dimiss and refresh Game UI
                    let rank = CMDBManager.shared.fetchUserRank(score: self.presenter?.totalScore ?? 0) ?? 0
                    let savingResult = CMDBManager.shared.saveUserInfo(userName: inputText, score: self.presenter?.totalScore ?? 0)
                    if savingResult.isDuplicate {
                        showAlert(title: "UserId exists already", message: message)
                    } else {
                        let rankTitle = rank == 0 ? "Not calculated": "Rank #\(rank)"
                        showAlert(title: rankTitle, message: "Score: \(self.presenter?.totalScore ?? 0)", textFieldNeed: false)
                        refreshGame()
                    }
                } else {
                    showAlert(title: validationResult.messge, message: message)
                }
            }
        }
        
    }
    
    func disableUser(for duration: TimeInterval) {
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [unowned self] in
            self.view.isUserInteractionEnabled = true
        }
    }
}

