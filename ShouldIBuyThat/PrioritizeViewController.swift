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
    @IBOutlet weak var itemsTableView: UITableView!
    
    var priorityValue = "med"
    var textfieldsValidated = false
    var datePopupValidated = false
    var setTimes = (current: Date(), selected: Date())
    
    var priorityItems: [String] = []
    var priorityDetails: [String] = []
    

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
        addItemsFromMain()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarVC = self.tabBarController as! ItemTabBarController
        myItems = tabBarVC.myItems
        
        itemsTableView.tableFooterView = UIView(frame: CGRect.zero) // keep extra rows from displaying
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) // allows user to tap outside of keyboard to close it (mainly for the decimal keyboards (no return button))
    }
   
    
    @IBAction func addToListClicked(_ sender: UIButton) {
        
        setTimes = setTimesFor(currentDate: myItems.currentDate, selectedDate: myItems.selectedDate)
        
        textfieldsValidated = validateFor(textfields: itemLbl.text, costLbl.text, rateLbl.text)
        
        datePopupValidated = validateFor(dateValue: setTimes.selected, wheneverValue: myItems.whenever, currentDate: setTimes.current)
        
        if datePopupValidated == true && textfieldsValidated == true
        {
            setNewValuesToModel(including: setTimes.current, setTimes.selected)

            insertNewPriority()
            
            resetFields()
            
        }
    }
    
    func addItemsFromMain(){
        if myItems.addToPrioritize == true && myItems.selected == true
        {
            setTimes = setTimesFor(currentDate: myItems.currentDate, selectedDate: myItems.selectedDate)
            itemLbl.text = myItems.item
            costLbl.text = String(myItems.price)
            rateLbl.text = String(myItems.rate)
            whenBtn.setTitle("\(formatDate(myItems.selectedDate)) is chosen, click to change", for: .normal)
        }
        else if myItems.addToPrioritize == true && myItems.selected == false
        {
            setTimes = setTimesFor(currentDate: myItems.currentDate, selectedDate: myItems.selectedDate)
            itemLbl.text = myItems.item
            costLbl.text = String(myItems.price)
            rateLbl.text = String(myItems.rate)
            whenBtn.setTitle("Whenever is chosen, click to change", for: .normal)
        }
        
    }
    
    func setNewValuesToModel(including current: Date, _ selected: Date) {
        myItems.item = itemLbl.text!
        myItems.price = Double(costLbl.text!)!
        myItems.rate = Double(rateLbl.text!)!
        myItems.currentDate = current
        myItems.selectedDate = selected

    }
    
    func insertNewPriority() {
        var rowDetails = ""
        
        myItems.getHoursNeeded()
        
        if myItems.validateHours == true
        {
        
            if myItems.selected == true
            {
                rowDetails = "Cost: $\(myItems.price) Hrs/Day: \(myItems.getHoursDays.hours)/\(myItems.getHoursDays.days)  Due: \(formatDate(myItems.selectedDate))"
            
                finishBuildingRow(with: rowDetails)
            }
            else if myItems.selected == false
            {
                rowDetails = "Cost: $\(myItems.price)  Hrs: \(myItems.getHoursDays.hours)  Due: Whenever"
                finishBuildingRow(with: rowDetails)
            }
        }
        else
        {
            displayNotEnoughTimeError()
        }
       
    }
    
    func finishBuildingRow(with rowDetails: String) {
        
        let rowTitle = myItems.item
        
        priorityItems.append(rowTitle) // append new item to array that will hold values in table
        priorityDetails.append(rowDetails)
        
        let indexPath = IndexPath(row: priorityItems.count - 1, section: 0) // add the new value to end of table
        
        itemsTableView.beginUpdates()
        itemsTableView.insertRows(at: [indexPath], with: .automatic)
        itemsTableView.endUpdates()
    }
    
    func resetFields() {
        itemLbl.text = ""
        costLbl.text = ""
        rateLbl.text = ""
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
        textField.textColor = UIColor.black
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { // func to close the keyboard when return is selected
        textField.resignFirstResponder()
        return true
    }
    
}

extension PrioritizeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let priorityTitle = priorityItems[indexPath.row]
      let priorityDetail = priorityDetails[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.nameLbl.text = priorityTitle // change to data that will be passed
        cell.detailsLbl.text = priorityDetail
        cell.getColorFor(priorityValue)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priorityItems.count // change to amount of data to be passed
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // gives ability to edit rows
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            priorityItems.remove(at: indexPath.row) // remove item from arrays
           priorityDetails.remove(at: indexPath.row)
            
            itemsTableView.beginUpdates()
            itemsTableView.deleteRows(at: [indexPath], with: .automatic) // delete row from table
            itemsTableView.endUpdates()
        }
    }
    
}



