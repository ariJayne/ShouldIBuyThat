//
//  ItemModel.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/28/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class ItemModel: NSObject {
    var item = ""
    var price = 0.0
    var rate = 0.0
    var selected = false
    var currentDate = Date()
    var selectedDate = Date()
    
    let numberFormatter: NumberFormatter = { // format for decimal places
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    func getHoursNeeded(with currentDate: Date, _ selectedDate: Date) -> String {
        let hoursNeeded = price / rate
        
        if selected == true
        {
            let components = Calendar.current.dateComponents([.day], from: currentDate, to: selectedDate)
            if let days = components.day
            {
                let hoursPerDay = hoursNeeded / Double(days)
                if let hoursPerDay = numberFormatter.string(from: NSNumber(value: hoursPerDay))
                {
                    return "\(hoursPerDay) per day for \(days) days"
                }
            }
        }
        else
        {
            if let hoursNeeded = numberFormatter.string(from: NSNumber(value: hoursNeeded))
            {
                return "\(hoursNeeded) hours total"
            }
        }
        return ""
}

}// end class
