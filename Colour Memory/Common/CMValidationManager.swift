//
//  CMValidationManager.swift
//  Colour Memory
//
//  Created by Bhupesh on 21/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import Foundation
class CMValidationManager {
    static func isValidUserId(userId: String) -> (isValid: Bool, messge: String) {
        let regEx = "\\w{1,16}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        let isValid = test.evaluate(with: userId)
        if isValid {
            return (true, "UserId is valid")
        }
        return (false, "UserId has invalid format")
    }
}
