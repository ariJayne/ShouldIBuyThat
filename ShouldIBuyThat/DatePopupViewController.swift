//
//  DatePopupViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class DatePopupViewController: UIViewController {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var wheneverBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
   
    var whenever: String = "whenever" // to be passed back to show whenever was clicked
    var delegate: PopupDelegate?
    
    // create property to format date
    // read only / computed
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func wheneverBtnClicked(_ sender: UIButton) {
        delegate?.popupValueSelected(value: whenever)
        dismiss(animated: true)
    }
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        // call doneClicked func to pass the date
        //doneClicked?(formattedDate)// optional in case nil
        delegate?.popupValueSelected(value: formattedDate)
        dismiss(animated: true)
    }// end doneBtnClicked func
    

}
