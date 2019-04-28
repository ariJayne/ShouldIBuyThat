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
   
    var whenever: String = "" // to be passed back to show whenever was clicked
    var delegate: PopupDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())
    }
    
    @IBAction func wheneverBtnClicked(_ sender: UIButton) {
        whenever = "whenever"
        delegate?.popupWheneverSelected(value: whenever)
        dismiss(animated: true)
    }
    
    @IBAction func doneBtnClicked(_ sender: UIButton) {
        let date = datePicker.date
        // call doneClicked func to pass the date
        //doneClicked?(formattedDate)// optional in case nil
        delegate?.popupDoneSelected(value: date)
        dismiss(animated: true)
    }// end doneBtnClicked func
    

}
