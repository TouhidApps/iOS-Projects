//
//  VCMemberList+ChatTableView.swift
//  Consult App
//
//  Created by Touhid on 10/9/18.
//  Copyright © 2018 Touhid Apps!. All rights reserved.
//

import UIKit

extension VCSingleChatRoom: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCellChatMessage", for: indexPath) as! TableViewCellChatMessage
        let mData = self.chatModel[indexPath.row]
//        mCell.setDataToView(profilePicUrl: "http://fboverlays.com/pages/assets/frontend/img/previewImage.png", chatText: mData.chatText)
        mCell.setDataToView(chatModel: mData)

        return mCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       NSLog("VCSingleChatRoom click item " + self.chatModel[indexPath.row].chatText, "")
    }

    
}

