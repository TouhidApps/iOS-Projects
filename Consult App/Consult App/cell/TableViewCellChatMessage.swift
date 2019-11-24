//
//  TableViewCellChatMessage.swift
//  Consult App
//
//  Created by Touhid on 10/9/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit
import Nuke


class TableViewCellChatMessage: UITableViewCell {
    
    @IBOutlet weak var imageViewProfilePc: UIImageView!
    @IBOutlet weak var labelChatText: UILabel!
    
    public func setDataToView(chatModel: ChatModel){
        designLayout(chatModel: chatModel)
        Nuke.loadImage(with: URL(string: "http://fboverlays.com/pages/assets/frontend/img/previewImage.png")!, into: imageViewProfilePc!)
        self.labelChatText.text = chatModel.chatText
    }
    
    func designLayout(chatModel: ChatModel) {
        self.labelChatText.layer.cornerRadius = 25
        self.labelChatText.clipsToBounds = true
    
        if chatModel.email == MyConstants.USER_EMAIL_TEMP {
            self.imageViewProfilePc.isHidden = true
            self.labelChatText.textAlignment = .right
        } else {
            self.imageViewProfilePc.isHidden = false
            self.labelChatText.textAlignment = .left
        }
        
    }
    
}
