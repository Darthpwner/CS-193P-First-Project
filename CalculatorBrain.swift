//
//  CalculatorBrain.swift
//  CS 193P First Project
//
//  Created by Matthew Allen Lin on 7/18/15.
//  Copyright (c) 2015 Matthew Allen Lin. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op: Printable
    {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var description: String
        {
            get
            {
                switch self
                {
                    case .OPerand(let operand):
                        return "\(operand)"
                    case .UnaryOperation(let symbol, _):
                        return symbol
                    case .BinaryOperation(let symbol, _):
                        return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init()
    {
        func learnOp(op: Op)
        {
            knowOps[op.description] = op
        }
        
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}   //Can't call the operator function because order matters
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}   //Can't call the operator function because order matters
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
    }

    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty
        {
            var remainingOps = ops //Makes a copy that is mutable
            let op = remainingOps.removeLast()
            switch op
            {
                case .Operand(let operand):
                    return (operand, remainingOps)
                case .UnaryOperation(_,let operation):
                    let operandEvaluation = self.evaluate(remainingOps)  //Value is a tuple
                    if let operand = operandEvaluation.result  //Type is optional
                    {
                        return (operation(operand), operandEvaluation.remainingOps)
                    }
                case .BinaryOperation(_, let operation):
                    let op1Evaluation = self.evaluate(remainingOps)
                    if let operand1 = op1Evaluation.result
                    {
                        let op2Evaluation = self.evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result
                        {
                            return (operation(operand1, operand2), op2Evaluation.remainingOps)
                        }
                    }
        }
        
        return (nil, ops)   //Default is to return nill
    }
    
    func evaluate() -> Double? //Optional because sometimes there isn't anything on the stack when you evaluate
    {
        let (result, remainder) = self.evaluate(opStack)    //"self" is adopted from Objective-C
        println("\opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double?
    {
        opStack.append(Op.Operand(operand))
        return evaluate()
        
    }
    
    func performOperation(symbol: String)
    {
        if let operation = knownOps[symbol]
        {
            opStack.append(operation)
        }
    }
 
};