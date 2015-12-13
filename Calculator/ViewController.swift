//
//  ViewController.swift
//  Calculator
//
//  Created by mac on 2015. 10. 30..
//  Copyright © 2015년 reken. All rights reserved.
//

import UIKit

class ViewController: UIViewController 
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber:Bool = false
    
    var brain = CalculatorBrain()
    

    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber =  true
        }
        print("Digit = \(digit)")
    }

    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle{
            if let result = brain.performOpertion(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }
    }
    
    private func performOperation(operation:(Double,Double)->Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation1(operation:(Double) -> Double) {
        if operandStack.count > 0 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func multiply(op1: Double, op2: Double) -> Double {
        return op1 * op2
    }
    
    var operandStack:Array<Double> = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }
        else {
            displayValue = 0
        }
    }
    
    var displayValue:Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

