//
//  MyCustomView.swift
//  XibExample
//
//  Created by Touhid on 2/3/19.
//  Copyright © 2019 Touhid Apps!. All rights reserved.
//

import UIKit

class MyCustomView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    override init(frame: CGRect) { // to create programmatically
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // system calls this initializer
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        // your stuff here
        Bundle.main.loadNibNamed("MyCustomView", owner: self, options: nil) // loaded the xib by name from memory
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
