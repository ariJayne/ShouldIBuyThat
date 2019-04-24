//
//  PrioritizeViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class PrioritizeViewController: UIViewController, PopupDelegate {
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares data for segue before it is displayd to user
        let popup = segue.destination as! DatePopupViewController // destination is the VC the segue is going TO
        popup.delegate = self
    }
    
    func popupValueSelected(value: String) {
        date = value
    }
    
}// end class
