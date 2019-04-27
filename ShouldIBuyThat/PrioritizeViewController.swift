//
//  PrioritizeViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class PrioritizeViewController: UIViewController {
    
    @IBOutlet weak var itemLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var rateLbl: UITextField!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var addBtn: UIButton!
    
    var name: String = ""
    var cost: String = ""
    var rate: String = ""
    var priorityValue: String = "med"
    var popupValueSelected: String = ""
    var selected: Bool = false
    var textfieldsValidated = false
    var datePopupValidated = false
    
    var currentDate = Date()
    var selectedDate = Date()
    var whenever: String = ""
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        sender.setValue(Float(lroundf(prioritySlider.value)), animated: true)
        switch sender.value {
        case 1:
            priorityLbl.text = "Low"
            priorityValue = "low"
        case 2:
            priorityLbl.text = "Med"
            priorityValue = "med"
        case 3:
            priorityLbl.text = "High"
            priorityValue = "high"
        default:
            priorityLbl.text = ""
            priorityValue = "fwgew"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
        
        itemLbl.text = name
        costLbl.text = cost
        rateLbl.text = rate
    }
   
    
    @IBAction func addToListClicked(_ sender: UIButton) {
    let setDates = setDatesFor(currentDate: currentDate, selectedDate: selectedDate)
    textfieldsValidated = validateFor(textfields: name, cost, rate)
    datePopupValidated = validateFor(dateValue: setDates.selected, wheneverValue: whenever, currentDate: setDates.current)
        
    if datePopupValidated == true && textfieldsValidated == true
    {
        addBtn.isEnabled = true
    } else {
        addBtn.isEnabled = false
    }
        
       print("cool")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares data for segue before it is displayd to user
        if segue.identifier == "toDatePopupViewController"
        {
            let popup = segue.destination as! DatePopupViewController // destination is the VC the segue is going TO
            popup.delegate = self
        }
    }

}// end class


extension PrioritizeViewController: PopupDelegate {
    func popupWheneverSelected(value: String) { //delegate functions
        whenever = value
        selected = false
        
    }
    func popupDoneSelected(value: Date) {
        selectedDate = value
        selected = true
        
    }
}


extension PrioritizeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        addBtn.isEnabled = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
}
