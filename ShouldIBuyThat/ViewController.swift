//
//  ViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/18/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var howManyHrsLbl: UILabel!
    @IBOutlet weak var whatLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var rateLbl: UITextField!
    
    @IBOutlet weak var whenBtn: UIButton!
    @IBOutlet weak var clickHerebtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var displayLbl: UILabel!

    var whenever: String = ""
    var datePopupValidated = false
    var textfieldsValidated = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
    
    @IBAction func findOutClicked(_ sender: UIButton) {
        
        let setDates = setDatesFor(currentDate: currentDate, selectedDate: selectedDate)
       
        textfieldsValidated = validateFor(textfields: whatLbl.text, rateLbl.text, costLbl.text)
        datePopupValidated = validateFor(dateValue: setDates.current, wheneverValue: whenever, currentDate: setDates.selected)
        
        if datePopupValidated == true && textfieldsValidated == true {
            addBtn.isHidden = false
        } else {
            addBtn.isHidden = true
        }
   
       
        
    }// end findOutClicked function
    
   
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares data for segue before it is displayd to user
        if segue.identifier == "toDatePopupViewController"
        {
            let popup = segue.destination as! DatePopupViewController // destination is the VC the segue is going TO
            popup.delegate = self
            
        } 
    }

}// end class



extension ViewController: PopupDelegate {
    
    func popupWheneverSelected(value: String) { //delegate functions
        whenever = value
        selected = false
    }
    
    func popupDoneSelected(value: Date) {
        selectedDate = value
        selected = true
    }
    
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        addBtn.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
}
