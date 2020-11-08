//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by brandon on 2020-10-07.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    mutating func calculateBMI(height: Float, weight: Float){
        let bmiValue = weight / pow(height, 2)
        var color = UIColor.clear
        var advice = ""
         
        switch bmiValue {
        case 0..<18.5:
            color = #colorLiteral(red: 0.2891509547, green: 0.6598342747, blue: 0.867632772, alpha: 1)
            advice = "Eat more pies!"
        case 18.5..<24.9:
            color =  #colorLiteral(red: 0.3963097736, green: 0.867632772, blue: 0.6950221108, alpha: 1)
            advice = "Fit as a fiddle!"
        default:
            color = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            advice = "Eat less pies!"
        }
        
        bmi = BMI(value: bmiValue, advice: advice, color: color)
    }
    
    func getAdvice() -> String{
        return bmi?.advice ?? "No advice for you"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? .clear
    }
    
    func getBMIValue() -> String {
        return String(format: "%.1f", bmi?.value  ?? 0.0)
    }
}
