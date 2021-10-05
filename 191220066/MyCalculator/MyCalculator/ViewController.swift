//
//  ViewController.swift
//  MyCalculator
//
//  Created by mac on 2021/10/5.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLabel.text = "0"
    }
    var inTypingMode = false
    var digitOnDisplay:String{
        get{
            return self.displayLabel.text!
        }
        set{
            self.displayLabel.text! = newValue
        }
    }
    @IBAction func numberTouched(_ sender:UIButton) {
        if inTypingMode {
            self.digitOnDisplay +=  sender.currentTitle!
        }
        else{
            self.digitOnDisplay = sender.currentTitle!
            inTypingMode = true
        }
        calculator.setInputNumber(number: Double(self.digitOnDisplay)!)
        //calculator.setIsNumber(flag:true)
    }
    
    @IBAction func operatorTouched(_ sender: UIButton) {
        //print(sender.currentTitle!)
        inTypingMode = false
        if let op = sender.currentTitle {
            
            if let result = calculator.performOnOperation(operation:op,operand:Double(digitOnDisplay)!){
                digitOnDisplay = String(result)
            }
        }
    }
    let calculator = Calculator()
    
}

