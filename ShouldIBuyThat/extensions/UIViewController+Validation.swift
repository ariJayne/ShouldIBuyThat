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
    
    func validateFor(textfields: String?...) -> Bool {
        for textfield in textfields {
            if let textfield = textfield
            {
                if textfield.isEmpty
                {
                    let myAlert = UIAlertController(title: "Alert", message: "All fields required", preferredStyle: UIAlertController.Style.alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil )
                    
                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true)
                    return false
                }
            }
        }
        return true
    }// end func
    
    func validateFor(dateValue: Date, wheneverValue: String, currentDate: Date) -> Bool {
        if dateValue == currentDate && wheneverValue == ""
        {
            let myAlert = UIAlertController(title: "Alert", message: "Please choose a date or select whenever", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil )
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true)
            return false // not valid
            
        }
        return true // return validated
    }
    
    
    func displayNotEnoughTimeError() {

        let myAlert = UIAlertController(title: "Alert", message: "Hours needed exceed 24 hours per day. Please try a different date or select whenever", preferredStyle: UIAlertController.Style.alert)
            
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil )
            
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true)
        
    }
        
}// end extension
