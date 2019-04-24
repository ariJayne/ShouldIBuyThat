//
//  ViewController.swift
//  ShouldIBuyThat
//
//  Created by Ariana on 4/18/19.
//  Copyright © 2019 Ariana. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PopupDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var howManyHrsLbl: UILabel!
    @IBOutlet weak var whatLbl: UITextField!
    @IBOutlet weak var costLbl: UITextField!
    @IBOutlet weak var howMuchLbl: UITextField!
    @IBOutlet weak var whenBtn: UIButton!
    @IBOutlet weak var clickHerebtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "" // clear texfield when user taps
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
 
    @IBAction func findOutClicked(_ sender: UIButton) {
        // do calculations with values entered by user
        // first make sure all fields have been filled
        /* if they did not select whenever:
            -FIRST CHECK DATE IS AHEAD OF TODAY, IF ANSWER
                IS 0, then only account for today)
            date wanted - todays date = number of days
            cost of item / rate per hour = number of hours
            number of days / number of hours = hours per day
            if hours exceed 24 per day, say not possible
            if hours exceed 12 per day, set a warning
         */
        let what = whatLbl.text!
        let cost = costLbl.text!
        let rate = howMuchLbl.text!
        
        
        validateFor(what: what,cost: cost,rate: rate)
        /*
         if whenever,
            only need to do cost of item / rate per hour to get total hours needed, can / 8 to see how many 8 hour days it would take.
        */
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




