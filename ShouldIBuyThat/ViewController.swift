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
    @IBOutlet weak var displayLbl: UILabel!

    let numberFormatter: NumberFormatter = { // format for decimal places
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    var date: Date?
    var whenever: String = ""
    var selected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (for the decimal keyboards)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        addBtn.isHidden = true
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
 
    @IBAction func findOutClicked(_ sender: UIButton) {
        /* if they did not select whenever:
            -FIRST CHECK DATE IS AHEAD OF TODAY, IF ANSWER
                IS 0, then only account for today)
            date wanted - todays date = number of days
            cost of item / rate per hour = number of hours
            number of days / number of hours = hours per day
            if hours exceed 24 per day, say not possible
            if hours exceed 12 per day, set a warning
         */
        let what = whatLbl.text
        let cost = costLbl.text
        let rate = howMuchLbl.text
        
        var currentDate = Date()
        let calendar = Calendar(identifier: .gregorian) // use to set times of each date for easy comparison
        
        currentDate = calendar.startOfDay(for: currentDate)
        if let d = date
        {
            date = calendar.startOfDay(for: d)
        }
        
        validateFor(what: what,cost: cost,rate: rate)
        
       
        if let cost = cost, let c = Double(cost), let rate = rate, let r = Double(rate)
        {
            let hoursNeeded = c / r
        
            if selected == true // if done is selected
            {
                if let date = date
                {
                    let components = Calendar.current.dateComponents([.day], from: currentDate, to: date) // get amt days between current date and date chosen
                    if let daysDifference = components.day
                    {
                        let hoursPerDay = hoursNeeded / Double(daysDifference)
                        if let hoursPerDay = numberFormatter.string(from: NSNumber(value: hoursPerDay))
                        {
                            print(daysDifference, hoursPerDay)
                        }
                    }
                }
            } else // if whenever is selected
                {
                    if let hoursNeeded = numberFormatter.string(from: NSNumber(value: hoursNeeded))
                    {
                        print(hoursNeeded)
                        displayLbl.text = "\(hoursNeeded) Hours"
                    }
                }
                addBtn.isHidden = false
            }
        
    }// end findOutClicked function
    
    @IBAction func addToPrioritizeClicked(_ sender: UIButton) {
        
        validateFor(what: whatLbl.text, cost: costLbl.text, rate: howMuchLbl.text)
        performSegue(withIdentifier: "toPrioritizeViewController", sender: self)
        
    }
    
    
   func validateFor(what: String?, cost: String?, rate: String?) {
    if let what = what, let cost = cost, let rate = rate
    {
        if what.isEmpty || cost.isEmpty || rate.isEmpty
            {
                let myAlert = UIAlertController(title: "Alert", message: "All fields required", preferredStyle: UIAlertController.Style.alert)
            
                let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil )
            
                myAlert.addAction(okAction)
                self.present(myAlert, animated: true)
                return
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // prepares data for segue before it is displayd to user
        if segue.identifier == "toDatePopupviewController"
        {
            let popup = segue.destination as! DatePopupViewController // destination is the VC the segue is going TO
            popup.delegate = self
            
        } else if segue.identifier == "toPrioritizeViewController"
        {
            let prioritizeVC = segue.destination as! PrioritizeViewController
            
            prioritizeVC.name = whatLbl.text ?? ""
            prioritizeVC.payRate = howMuchLbl.text ?? ""
            prioritizeVC.price = costLbl.text ?? ""
        }
    }
    
    func popupWheneverSelected(value: String) {
        whenever = value
        selected = false
    }
    func popupDoneSelected(value: Date) {
        date = value
        selected = true
    }
    
   
}// end class




