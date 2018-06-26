//
//  ViewController.swift
//  Calculator App
//
//  Created by Touhid on 6/26/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelResultView: UILabel!
    
    
    var tempValue = 0
    var tempSymbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    } // END viewDidLoad
    
    
    @IBAction func buttonNine(_ sender: UIButton) {
        self.labelResultView.text = "9"
    }
    @IBAction func buttonEight(_ sender: UIButton) {
        self.labelResultView.text = "8"
    }
    @IBAction func buttonSeven(_ sender: UIButton) {
        self.labelResultView.text = "7"
    }
    @IBAction func buttonSix(_ sender: UIButton) {
        self.labelResultView.text = "6"
    }
    
    @IBAction func buttonFive(_ sender: UIButton) {
        self.labelResultView.text = "5"
    }
    @IBAction func buttonFour(_ sender: UIButton) {
        self.labelResultView.text = "4"
    }
    @IBAction func buttonThree(_ sender: UIButton) {
        self.labelResultView.text = "3"
    }
    @IBAction func buttonTwo(_ sender: UIButton) {
        self.labelResultView.text = "2"
    }
    @IBAction func buttonOne(_ sender: UIButton) {
        self.labelResultView.text = "1"
    }
    @IBAction func buttonZero(_ sender: UIButton) {
        self.tempValue = Int(self.labelResultView.text!)!
        self.labelResultView.text = "0"
    }
    
    
    @IBAction func buttonCancel(_ sender: UIButton) {
        self.tempValue = 0
        self.labelResultView.text = "0"
    }
    @IBAction func buttonEqual(_ sender: UIButton) {
        var res = 0
        switch self.tempSymbol {
        case "+":
                res = self.tempValue + Int(self.labelResultView.text!)!
            break
            
        case "-":
            res = self.tempValue - Int(self.labelResultView.text!)!
            break
            
        case "*":
            res = self.tempValue * Int(self.labelResultView.text!)!
            break
            
        case "/":
            res = self.tempValue / Int(self.labelResultView.text!)!
            break
            
        default:
                
            break
        }
       
        
        self.labelResultView.text = "\(res)"
    }
    @IBAction func buttonPlus(_ sender: UIButton) {
        self.tempValue = Int(self.labelResultView.text!)!
        self.labelResultView.text = "+"
        self.tempSymbol = "+"
    }
    @IBAction func buttonMinus(_ sender: UIButton) {
        self.tempValue = Int(self.labelResultView.text!)!
        self.labelResultView.text = "-"
        self.tempSymbol = "-"
    }
    @IBAction func buttonMultiple(_ sender: UIButton) {
        self.tempValue = Int(self.labelResultView.text!)!
        self.labelResultView.text = "*"
        self.tempSymbol = "*"
    }
    @IBAction func buttonDivide(_ sender: UIButton) {
        self.tempValue = Int(self.labelResultView.text!)!
        self.labelResultView.text = "/"
        self.tempSymbol = "/"
    }
    


 
    

}

