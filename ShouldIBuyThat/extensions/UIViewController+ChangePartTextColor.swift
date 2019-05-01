//
//  UIViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/30/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func changeTextColor(For text: String) -> NSMutableAttributedString {
        let txt = text
        let range = (txt as NSString).range(of: txt)
        
        let attributedString = NSMutableAttributedString(string: txt)
        
        switch text {
        case "low":
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
        case "med":
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: range)
        case "high":
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: range)
        default:
           attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)
        }
       
        return attributedString
    }
}
