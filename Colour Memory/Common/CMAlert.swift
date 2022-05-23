//
//  CMAlert.swift
//  Colour Memory
//
//  Created by Bhupesh on 21/05/22.
//  Copyright © 2022 Acd. All rights reserved.
//

import UIKit

class CMAlert {
    
    let textFieldNeed: Bool
    let title: String
    let message: String
    
    init(title: String, message: String, textFieldNeed: Bool) {
        self.title = title
        self.message = message
        self.textFieldNeed = textFieldNeed
    }
    
    func showAlert(base: UIViewController, completion: @escaping ((_ inputText: String) -> Void)) {
        
        let alert = UIAlertController(title: self.title, message: self.message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            let enteredtext = alert.textFields?.first?.text ?? ""
            completion(enteredtext)
        })
        
        if self.textFieldNeed {
            alert.addTextField { textField in
                textField.placeholder = "Please Enter here"
                textField.textAlignment = .center
            }
        }
        base.present(alert, animated: true, completion: nil)
    }
}
