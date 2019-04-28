//
//  PrioritizeViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class PrioritizeViewController: UIViewController {
    var myItems = ItemModel()
    
    @IBOutlet weak var itemLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var rateLbl: UITextField!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var whenBtn: UIButton!
    
    var selectedDate = Date()
    var priorityValue = "med"
    var textfieldsValidated = false
    var datePopupValidated = false
    var setDates = (current: Date(), selected: Date())

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
    
    override func viewWillAppear(_ animated: Bool) {
        itemLbl.text = myItems.item
        costLbl.text = String(myItems.price)
        rateLbl.text = String(myItems.rate)
        setDates = setDatesFor(currentDate: myItems.currentDate, selectedDate: myItems.selectedDate)

        if myItems.addToPrioritize == true && myItems.selected == true
        {
            whenBtn.setTitle("\(formatDate(myItems.selectedDate)) is chosen, click to change", for: .normal)
        }
        else if myItems.addToPrioritize == true && myItems.selected == false
        {
            whenBtn.setTitle("Whenever is chosen, click to change", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarVC = self.tabBarController as! ItemTabBarController
        myItems = tabBarVC.myItems
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
   
    
    @IBAction func addToListClicked(_ sender: UIButton) {
    
    textfieldsValidated = validateFor(textfields: itemLbl.text, costLbl.text, rateLbl.text)
    datePopupValidated = validateFor(dateValue: setDates.selected, wheneverValue: myItems.whenever, currentDate: setDates.current)
        
    if datePopupValidated == true && textfieldsValidated == true
    {
       print("validated")
    } else {
        print("not Validated")
        }
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
        myItems.whenever = value
        myItems.selected = false
        whenBtn.setTitle("Whenever selected, click to change", for: .normal)
    }
    func popupDoneSelected(value: Date) {
        myItems.selectedDate = value
        myItems.selected = true
        whenBtn.setTitle("\(formatDate(myItems.selectedDate)) is chosen, click to change", for: .normal)
    }
}


extension PrioritizeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
}
