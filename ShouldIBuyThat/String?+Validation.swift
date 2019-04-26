//
//  String?+Validation.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/25/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func validateFor(textfields: String?...) {
        for textfield in textfields {
            if let textfield = textfield
            {
                if textfield.isEmpty
                {
                    let myAlert = UIAlertController(title: "Alert", message: "All fields required", preferredStyle: UIAlertController.Style.alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil )
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true)
                    return
                }
            }
        }
    }// end func
}
