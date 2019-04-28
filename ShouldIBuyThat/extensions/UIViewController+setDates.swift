//
//  setDates.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/27/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setDatesFor(currentDate: Date, selectedDate: Date) -> (current: Date, selected: Date) {
        var currentDate = currentDate
        var selectedDate = selectedDate
        let calendar = Calendar(identifier: .gregorian)
            // use to set times of each date for easy comparison
        currentDate = calendar.startOfDay(for: currentDate)
        
        selectedDate = calendar.startOfDay(for: selectedDate)
       
        return (currentDate, selectedDate)
        
    }
    
    func formatDate(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "MMM dd, yyyy"
        return df.string(from: date)
    }
}// end extension


