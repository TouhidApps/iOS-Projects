//
//  ViewController.swift
//  LocalizationIniOS
//
//  Created by Touhid on 11/18/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelLanguage: UILabel!
    
    @IBAction func switchChangeLanguage(_ sender: UISwitch) {
        
        var localeString:String?
//        switch sender {
//        case englishButton: localeString = "en"
//        case spanishButton:
        localeString = "bn-BD"
//        default: localeString = nil
//        }
        
        
        if localeString != nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LANGUAGE_WILL_CHANGE"), object: localeString)
        }
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.languageDidChangeNotification(notification:)), name: NSNotification.Name(rawValue: "LANGUAGE_DID_CHANGE"), object: nil)
        languageDidChange()
        
        
    }
    
   
    
    @objc func languageDidChangeNotification(notification:NSNotification){
        languageDidChange()
    }
    
    func languageDidChange(){
        labelLanguage.text = NSLocalizedString("Hello", tableName: "Main", comment: "")
    }


}

