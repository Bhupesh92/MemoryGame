//
//  CMUIView.swift
//  Colour Memory
//
//  Created by Bhupesh on 18/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Set corner radius directly through xibs
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    /// Set  borderWidth directly through xibs
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    // Set  borderColor directly through xibs
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor.clear
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
}

// MARK: UIActivityIndicatorView methods
extension UIView {
    
    static let kActivityTag = 777
    
    /// It will show activity in the middle
    func showActivityIndicator() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.center
        activityView.tag = UIView.kActivityTag
        activityView.startAnimating()
        activityView.hidesWhenStopped = true
        self.addSubview(activityView)
    }
    
    /// It will remove activity in present
    func hideActivityIndicator() {
        if let aView = self.viewWithTag(UIView.kActivityTag) as? UIActivityIndicatorView {
            aView.stopAnimating()
            aView.removeFromSuperview()
        }
    }
}
