//
//  ViewController.swift
//  CS 193P First Project
//
//  Created by Matthew Allen Lin on 6/12/15.
//  Copyright (c) 2015 Matthew Allen Lin. All rights reserved.
//

import UIKit

//Definition of a class
class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingNumber = false
    
    var brain = CalculatorBrain()   //Green arrow in Hegarty's model
    
    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber
        {
            display.text = display.text! + digit
        }
        
        else
        {
            display.text = digit
            userIsInTheMiddleOfTypingNumber = true
        }
        
        println("digit = \(digit)")
    }
    
    
    @IBAction func operate(sender: UIButton)
    {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber
        {
            enter()
        }

        if let operation = sender.currentTitle
        {
            if let result = brain.performOperation(operation)
            {
                displayValue = result
            }
            
            else
            {
                displayValue = 0
            }
        }
        //Similar to C++
//        switch operation
//        {
//            case "ASIN": performSingleOperation{ asin($0) }
//            case "ACOS": performSingleOperation{ acos($0) }
//            case "ATAN": performSingleOperation{ atan($0) }
//            case "FLOOR": performSingleOperation{ floor($0) }
//            case "CEIL": performSingleOperation{ ceil($0) }
//            case "SIN": performSingleOperation{ sin($0) }
//            case "COS": performSingleOperation{ cos($0) }
//            case "TAN":
//                performSingleOperation{ tan($0) }
//            case "LOG": performSingleOperation { log($0) }
//            case "e^x": performSingleOperation{ exp($0) }
//            //Immediates refer to the arguments
//            case "AC": performSingleOperation({ Int in
//                self.operandStack.removeAll(keepCapacity: true)
//                return 0
//            })
//           // case "π": return getPi();
//            case "±": performSingleOperation ({ (Op1: Double) -> Double in
//                return 0 - Op1
//                
//            })
//            case "%": performOperation { $1 % $0 }  //2nd argument modulo by 1st argument
//            case "÷": performOperation { $1 / $0 }  //2nd argument divided by 1st argument
//            case "×": performOperation { $1 * $0 }  //2nd argument times 1st argument
//            case "−": performOperation { $1 - $0 }  //2nd argument minus 1st argument
//            case "+": performOperation { $1 + $0 }  //2nd argument plus 1st argument
////            case "(":
////            case ")":
//            case "^": performOperation { pow($1, $0) }
//            case"√": performSingleOperation { sqrt($0) }
//            case ".": performSingleOperation({ (Op1: Double) -> Double in
//                return Op1 * 1.0
//            })  //BUGGY!
//            default: break
//        }
    }

//    func performOperation(operation: (Double, Double) -> Double)
//    {
//        if operandStack.count >= 2
//        {
//            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
//            enter()
//        }
//    }
//    
//    func performSingleOperation(operation: Double -> Double)
//    {
//        if operandStack.count >= 1
//        {
//            displayValue = operation(operandStack.removeLast())
//            enter()
//        }
//    }
    
//    func getPi() -> Double
//    {
//        Double pi = 3.14159265358979323846264338327950288;
//        displayValue = self.pi;
//        return self.pi;
//    }
    
    //Initializes "operandStack" to an empty array of type double
    var operandStack = Array<Double>();
    
    @IBAction func enter()
    {
        userIsInTheMiddleOfTypingNumber = false
        if let result = brain.pushOperand(displayValue)
        {
            brain.pushOperand(displayValue)
        }
        else
        {
            displayValue = 0
        }
    }
    
    var displayValue: Double
    {
        //get is used to return the value from a string as a double
        get
        {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        //set is used to assign a value to display.text so it can be returned from "get" as a Double
        set
        {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false;
        }
    }
}

