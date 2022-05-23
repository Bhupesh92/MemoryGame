//
//  CMImageView.swift
//  Colour Memory
//
//  Created by Bhupesh on 20/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

enum CMFlipAnimation {
    case close, open
}

extension UIImageView {
    func flip( image: UIImage, _ animation: CMFlipAnimation) {
        var transitionOptions = UIView.AnimationOptions.transitionFlipFromRight
        switch animation {
        case .close:
            break
        case .open:
            transitionOptions = .transitionFlipFromLeft
        }
        
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            self.image = image
            }, completion: { finished in
        })
    }
}
