//
//  Calculator.swift
//  MyCalculator
//
//  Created by mac on 2021/10/5.
//

import UIKit

class Calculator: NSObject {
    enum Operation{
        case UnaryOp((Double)->Double?)
        case BinaryOp((Double,Double)->Double?)
        case EqualOp
        case Constant(Double)
    }
    var operations = [
        "=":Operation.EqualOp,
        "+":Operation.BinaryOp{
            (x, y)  in
            return x + y
        },
        "-":Operation.BinaryOp{
            (x, y)  in
            return x - y
        },
        "×":Operation.BinaryOp{
            (x, y)  in
            return x * y
        },
        "÷":Operation.BinaryOp{
            (x, y)  in
            return x / y
        },
        "x^y":Operation.BinaryOp{
            (x, y)  in
            return pow(x,y)
        },
        "y√x":Operation.BinaryOp{
            (x, y)  in
            return pow(x,1/y)
        },
        
        "e":Operation.Constant(2.7182818),
        "π":Operation.Constant(3.1415927),
        "+/-":Operation.UnaryOp{
            x in
            return -x
        },
        
        "%":Operation.UnaryOp{
            x in
            return x/100
        },
        "sin":Operation.UnaryOp{
            x in
            return sin(x)
        },
        "cos":Operation.UnaryOp{
            x in
            return cos(x)
        },
        "tan":Operation.UnaryOp{
            x in
            return tan(x)
        },
        "sinh":Operation.UnaryOp{
            x in
            return sinh(x)
        },
        "cosh":Operation.UnaryOp{
            x in
            return cosh(x)
        },
        
        "x^2":Operation.UnaryOp{
            x in
            return pow(x,2)
        },
        "x^3":Operation.UnaryOp{
            x in
            return pow(x,3)
        },
        "e^x":Operation.UnaryOp{
            x in
            return exp(x)
        },
        
        "10^x":Operation.UnaryOp{
            x in
            return pow(10,x)
        },
        
        "1/x":Operation.UnaryOp{
            x in
            return 1/x
        },
        "2√x":Operation.UnaryOp{
            x in
            return sqrt(x)
        },
        "3√x":Operation.UnaryOp{
            x in
            return pow(x,1/3)
        },
        "ln":Operation.UnaryOp{
            x in
            return log(x)
        },
        "lg":Operation.UnaryOp{
            x in
            return log10(x)
        },
        "x!":Operation.UnaryOp{
            x in
            return 1
            //assert(false)
        }
    ]
    
    struct Intermediate{
        var firstOp:Double
        var waitingOperation:(Double,Double)->Double?
    }
    var pendingOp:Intermediate? = nil
    
    var inputNumber:Double = 0.0
    func setInputNumber(number:Double){
        inputNumber = number
    }
    var isNumber:Bool = true
    func setIsNumber(flag:Bool){
        self.isNumber = flag
    }
    func performOnOperation(operation:String,operand:Double)->Double? {
        
        if var op = operations[operation]{
            switch op {
             case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp:operand,waitingOperation:function)
                isNumber = false
                inputNumber = operand
                return nil
            case .Constant(let value):
                isNumber = true
                return value
            case .EqualOp:
                if isNumber{
                    return operand
                }
                else{
                    var ret =  pendingOp!.waitingOperation(pendingOp!.firstOp,inputNumber)
                    pendingOp?.firstOp = ret ?? pendingOp?.firstOp as! Double
                    return ret
                }
            case .UnaryOp(let function):
                isNumber = true
                return function(operand)
            default :
                return nil
            }
        }
        return nil
    }
}
