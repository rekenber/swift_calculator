//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by mac on 2015. 12. 3..
//  Copyright © 2015년 reken. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String,Double -> Double)
        case BinaryOperation(String,(Double,Double)->Double)
    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()
    
    init(){
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√",sqrt) 
    }
    
    func evaluation()-> Double?{
    }
    
    func pushOperand(operand:Double){
        opStack.append(Op.Operand(operand))
    }
    
    func performOpertion(symbol: String){
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}
