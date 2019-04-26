//
//  PrioritizeViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class PrioritizeViewController: UIViewController, PopupDelegate {
    
    @IBOutlet weak var itemLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var rateLbl: UITextField!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    @IBOutlet weak var addBtn: UIButton!
    
    var name = String()
    var price = String()
    var payRate = String()
    //var popupDelegate: PopupDelegate?
    
    var date: Date?
    var whenever: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
    
    @IBAction func addToListClicked(_ sender: UIButton) {
        
        let item = itemLbl.text!
        let cost = costLbl.text!
        let rate = rateLbl.text!
        
        validateFor(textfields: cost, rate, item)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares data for segue before it is displayd to user
        let popup = segue.destination as! DatePopupViewController // destination is the VC the segue is going TO
        popup.delegate = self
    }
    
    func popupWheneverSelected(value: String) {
        whenever = value
    }
    
    func popupDoneSelected(value: Date) {
        date = value
    }
    
}// end class


extension DatePopupViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        addBtn.isHidden = true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
}
