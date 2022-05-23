//
//  CMConstant.swift
//  Colour Memory
//
//  Created by Bhupesh on 19/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

struct CMConstant {
    
    static let estimatedCellHeight = 200.0
    static let maxPair = 8
    static let throttle = 0.5
    
    struct Identifier {
        static let cmCard = "CMCard"
        static let cmScoreCell = "CMHighScoreCell"
    }
    
    struct Card {
        static let itemSpacing = 4.0
        static let lineSpacing = 4.0
    }
    
    static func calculateCardSize(for collectionViewSize: CGSize) -> CGSize {
        let cardHeight = (collectionViewSize.height - 3*Card.lineSpacing)/4 // It will 4x4 always
        let cardWidth = (collectionViewSize.width - 3*Card.itemSpacing)/4
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
}
