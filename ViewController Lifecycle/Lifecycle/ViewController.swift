//
//  ViewController.swift
//  ClassOne
//
//  Created by Touhid on 5/28/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var student: Student? = Student()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(#file) Line: \(#line) Function: \(#function)")
     //   print(getStudent())
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("\(#file) Line: \(#line) Function: \(#function)")
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(#file) Line: \(#line) Function: \(#function)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(#file) Line: \(#line) Function: \(#function)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("\(#file) Line: \(#line) Function: \(#function)")
    }
    
    func getStudent()-> String {
        guard let stud = student else { return "Nothing found" }
        
        stud.name = "Touhid"
        stud.id = "22"
        stud.address = "Dhaka"
        return stud.name + stud.id + stud.address
        
    }
    


}

