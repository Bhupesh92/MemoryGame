//
//  CMCard.swift
//  Colour Memory
//
//  Created by Bhupesh on 18/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

class CMCard: UICollectionViewCell {
    private var image = "card_bg"
    var animation = CMFlipAnimation.close {
        didSet {
            guard let iView = UIImage(named: self.image) else {
                return
            }
            self.cardImageView.flip(image: iView, self.animation)
        }
    }
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCard(animation: CMFlipAnimation, image: String) {
        self.image = image
        self.animation = animation
    }

}
