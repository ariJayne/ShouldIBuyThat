//
//  CustomTableViewCell.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/30/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    
    func getColorFor(_ priority: String) {
        priorityLbl.text = priority
        
        switch priority
        {
        case "low":
            priorityLbl.backgroundColor = UIColor.yellow
        case "med":
            priorityLbl.backgroundColor = UIColor.orange
        case "high":
            priorityLbl.backgroundColor = UIColor.red
        default:
            print("something went wrong.")
        }
    }
    
}// end class
