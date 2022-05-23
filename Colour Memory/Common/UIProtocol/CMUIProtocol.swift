//
//  CMUIProtocol.swift
//  Colour Memory
//
//  Created by Bhupesh on 21/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation

/// Conform this protocol to every entity which will contact to UI

protocol CMUIProtocol {
    func getName() -> String
    func getScore() -> Int16
}

extension CMUIProtocol {
    
    func getName() -> String {
        ""
    }
    
    func getScore() -> Int16 {
        0
    }
    
}

extension CMUser: CMUIProtocol {
    
    func getName() -> String {
        self.uId ?? ""
    }
    
    func getScore() -> Int16 {
        self.score
    }
    
}
