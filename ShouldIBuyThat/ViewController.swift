//
//  ViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/18/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var myItems = ItemModel()
    
    @IBOutlet weak var howManyHrsLbl: UILabel!
    @IBOutlet weak var whatLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var rateLbl: UITextField!
    
    @IBOutlet weak var whenBtn: UIButton!
    @IBOutlet weak var clickHerebtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var displayLbl: UILabel!
    
    var datePopupValidated = false
    var textfieldsValidated = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarVC = self.tabBarController as! ItemTabBarController
        myItems = tabBarVC.myItems
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
    
    @IBAction func findOutClicked(_ sender: UIButton) {
        
        let setTimes = setTimesFor(currentDate: myItems.currentDate, selectedDate: myItems.selectedDate)

        textfieldsValidated = validateFor(textfields: whatLbl.text, rateLbl.text, costLbl.text)
        
        datePopupValidated = validateFor(dateValue: setTimes.current, wheneverValue: myItems.whenever, currentDate: setTimes.selected)
        
        if datePopupValidated == true && textfieldsValidated == true
        {
            myItems.item = whatLbl.text!
            myItems.price = Double(costLbl.text!)!
            myItems.rate = Double(rateLbl.text!)!
            myItems.currentDate = setTimes.current
            myItems.selectedDate = setTimes.selected
         
            displayLbl.text = myItems.getHoursNeeded()
            
            addBtn.isHidden = false
            addBtn.setTitle("Prioritize!", for: .normal)
            addBtn.backgroundColor = .red
            addBtn.setTitleColor(.white, for: .normal)
            // reset all fields
        }
        else
        {
            print("not valid")
            addBtn.isHidden = true
        }
        
        
      myItems.addToPrioritize = false
    }// end findOutClicked function
    
    @IBAction func addToListClicked(_ sender: UIButton) {
        myItems.item = whatLbl.text!
        myItems.price = Double(costLbl.text!)!
        myItems.rate = Double(rateLbl.text!)!
        
        addBtn.setTitle("Added to Prioritize", for: .normal)
        addBtn.backgroundColor = .green
        addBtn.setTitleColor(.darkGray, for: .normal)
        
        myItems.addToPrioritize = true
        // reset all fields
    }
    
   
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
        myItems.whenever = value
        myItems.selected = false
        whenBtn.setTitle("Whenever selected, click to change", for: .normal)
        myItems.addToPrioritize = false
    }
    
    func popupDoneSelected(value: Date) {
        myItems.selectedDate = value
        myItems.selected = true
        addBtn.isHidden = true
         whenBtn.setTitle("\(formatDate(myItems.selectedDate)) selected, click to change", for: .normal)
        myItems.addToPrioritize = false
    }
}


extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        addBtn.backgroundColor = .red
        addBtn.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
}
