//
//  TableViewCellMemberList.swift
//  Consult App
//
//  Created by Touhid on 7/24/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit
import SDWebImage


class TableViewCellMemberList: UITableViewCell {
    
    @IBOutlet weak var imageViewProfilePic: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPhoneNo: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    

    public func setDataToView(profilePicUrl: String, name: String, phone: String, email: String){
        self.imageViewProfilePic.sd_setImage(with: URL(string: profilePicUrl), placeholderImage: UIImage(named: "profile"))
        self.labelName.text = name
        self.labelPhoneNo.text = phone
        self.labelEmail.text = email
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
        
    }

}
