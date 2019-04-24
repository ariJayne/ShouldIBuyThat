//
//  PrioritizeViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/22/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class PrioritizeViewController: UIViewController, PopupDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var itemLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var rateLbl: UITextField!
    @IBOutlet weak var priorityLbl: UILabel!
    @IBOutlet weak var prioritySlider: UISlider!
    
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
    
    @IBAction func addToListClicked(_ sender: UIButton) {
        let item = itemLbl.text!
        let cost = costLbl.text!
        let rate = rateLbl.text!
        
        
       validateFor(what: item,cost: cost,rate: rate)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "" // clear texfield when user taps
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
        
    func validateFor(what: String, cost: String, rate: String) {
        if (what.isEmpty || cost.isEmpty || rate.isEmpty)
        {
            var myAlert = UIAlertController(title: "Alert", message: "All fields required", preferredStyle: UIAlertController.Style.alert)
                
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil )
                
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true)
            return
        }
    }
        
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares data for segue before it is displayd to user
        let popup = segue.destination as! DatePopupViewController // destination is the VC the segue is going TO
        popup.delegate = self
    }
    
    func popupValueSelected(value: String) {
        date = value
    }
    
}// end class
