//
//  String+ChangePartTextColor.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/30/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func changePartOfTextColor(fullText: String, changeText: String) {
        
        let strNum: NSString = fullText as NSString
        let range = (strNum).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
    }
}
