//
//  CMOrientationManager.swift
//  Colour Memory
//
//  Created by Bhupesh on 21/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit
class CMOrientationManager {
    
    static var landscapeSupported: Bool =  false
    
    static func forceRotateToPotraitScapeDevice() {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
    }
}
