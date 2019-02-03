//
//  ViewController.swift
//  XibExample
//
//  Created by Touhid on 2/3/19.
//  Copyright © 2019 Touhid Apps!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // mark 1
    @IBOutlet weak var myCustomView: MyCustomView!
    
    // mark x1 (Alternative way to init the xib)
    @IBOutlet weak var viewPlaceholder: UIView!
    var customViewBySwift: MyCustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // mark 2
        // by view
        myCustomView.labelTitle.text = "Touhid from storyboard view"
        myCustomView.myButton.addTarget(self, action: #selector(buttonClickEvent), for: .touchUpInside)
        
        // mark x2
        // by swift
        customViewBySwift = MyCustomView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        viewPlaceholder.addSubview(customViewBySwift)
        customViewBySwift.labelTitle.text = "Touhid second view from swift"
        customViewBySwift.myButton.addTarget(self, action: #selector(buttonClickEvent), for: .touchUpInside)
        
    } // viewDidLoad
    
    @objc func buttonClickEvent() {
        print("Button clicked")
    }


}

