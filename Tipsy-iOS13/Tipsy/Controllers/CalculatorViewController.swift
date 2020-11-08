//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper! 
    
    var tips = 0.0
    var total = 0.0
    var peopleAmount = 0
    var sum = 0.0
    
    override func viewDidLoad() {
        updateUI()
    }
    
    

    @IBAction func tipChanged(_ sender: UIButton) {
        
        sum = Double(billTextField.text ?? "0.0") ?? 0.0
        billTextField.endEditing(true)
        
        switch sender.currentTitle {
        case "0%":
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            tips = 0.0
            
        case "10%":
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = true
            twentyPctButton.isSelected = false
            tips = 10 / 100
            
        case "20%":
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = true
            tips = 20/100

        default:
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        }
        
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        stepper.maximumValue = 12
        splitNumberLabel.text = String(format: "%.0f", stepper.value)
        peopleAmount = Int(stepper.value)
    }
    
    @IBAction func calculatedPressed(_ sender: UIButton) {
        if(billTextField.text != ""){
        total = ((sum * tips) / Double(peopleAmount) + (sum * tips))
        }
        else{
            total = 0.0
        }
        
        performSegue(withIdentifier: "goToResults", sender: self)
        updateUI()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.peopleAmount = peopleAmount
            destinationVC.tipsAmount = tips * 100
            destinationVC.totalPerPerson = total
        }
    }
    
    func updateUI() {
        tips = 0
        stepper.value = 2
        peopleAmount = Int(stepper.value)
        sum = 0
        total = 0
        billTextField.text = ""
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        splitNumberLabel.text = String(format: "%.0f", stepper.value)

    }

}


