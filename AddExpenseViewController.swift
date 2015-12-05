//
//  AddExpenseViewController.swift
//  eWallet
//
//  Created by David Kababyan on 01/11/2015.
//  Copyright © 2015 David Kababyan. All rights reserved.
//

import UIKit
import CoreData

class AddExpenseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    var datePicker: UIDatePicker!
    
    var isExpense:Bool = true
    
    var expense: Expense?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        dateTextField.inputView = datePicker
        datePicker.addTarget(self, action: Selector("handleDatePicker"), forControlEvents: UIControlEvents.ValueChanged)
        
        dateTextField.delegate = self
        
        if let _ = expense {
            updateUI(expense!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableviewDataSource function
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        if indexPath.row == 0 {
            if isExpense {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.textLabel?.text = "Is Expense"
        } else if indexPath.row == 1 {
            if !isExpense {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
            cell.textLabel?.text = "Is Income"
        }
        
        
        return cell
    }
    
    //MARK: UITableviewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == 0 {
            isExpense = true
        } else if indexPath.row == 1 {
            isExpense = false
        }
        
        tableView.reloadData()
    }
    
    //MARK: IBActions
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        if nameTextField.text != "" && amountTextField.text != "" {
            if let _ = expense {
                datePicker.setDate(dateFromSreing(dateTextField.text!), animated: true)
                saveEdit()
            } else {
                saveNew()
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func dismissKeyboardButtonPressed(sender: UIButton) {
        self.view.endEditing(false)
    }
    
    //MARK: UITextfieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == dateTextField {
            if let _ = expense {
                datePicker.setDate(expense!.date!, animated: true)
            }
            handleDatePicker()
        }
    }
    
    
    //MARK: DatePicker functions

    func handleDatePicker() {
        dateTextField.text = stringFromDate(datePicker.date)
        
    }
    
    //MARK: Helper Functions
    
    func updateUI(expense: Expense) {
        nameTextField.text = expense.name
        amountTextField.text = "\(expense.amount!)"
        dateTextField.text = stringFromDate(expense.date!)
        isExpense = expense.isExpense!.boolValue
    }
    
    func dateFromSreing(string: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        return dateFormatter.dateFromString(string)!
    }
    
    func stringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        return dateFormatter.stringFromDate(date)
    }
    
    func saveEdit() {
        expense!.amount = Double(amountTextField.text!)!
        expense!.name = nameTextField.text!
        expense!.date = datePicker.date
        expense!.isExpense = isExpense
        expense!.dateString = stringFromDate(datePicker.date)
        expense!.weekOfTheYear = calendarComponents().weekOfYear
        expense!.monthOfTheYear = calendarComponents().month
        expense!.year = calendarComponents().year
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
    }
    
    func saveNew() {
        let entityDescription = NSEntityDescription.insertNewObjectForEntityForName("Expense", inManagedObjectContext: (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext) as! Expense
        
        //add calendar Units (week, month, year)
        entityDescription.weekOfTheYear = calendarComponents().weekOfYear
        entityDescription.monthOfTheYear = calendarComponents().month
        entityDescription.year = calendarComponents().year
        
        entityDescription.name = nameTextField.text!
        
        entityDescription.dateString = stringFromDate(datePicker.date)
        entityDescription.date = datePicker.date
        entityDescription.isExpense = isExpense
        entityDescription.amount = Double(amountTextField.text!)!
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
        
    }
    
    func calendarComponents() -> NSDateComponents {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.WeekOfYear, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: datePicker.date)
        
        return components
    }
    
    
    
}
