//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by brandon on 2020-10-13.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var totalPerPerson: Double?
    var peopleAmount: Int?
    var tipsAmount: Double?


    override func viewDidLoad() {

        totalLabel.text = String(format: "%.2f", totalPerPerson!)
        settingsLabel.text = "Split between \(peopleAmount!) people, with \(String(format: "%.0f",tipsAmount!))% tips."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

