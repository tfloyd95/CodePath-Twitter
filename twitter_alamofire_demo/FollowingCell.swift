//
//  FollowingCell.swift
//  twitter_alamofire_demo
//
//  Created by ARG Lab on 3/13/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class FollowingCell: UITableViewCell {
    
    var user: User!{
        didSet{
            profile.af_setImage(withURL: user.profileImageUrl!)
            screenNameLabel.text = user.screenName
            usernameLabel.text = user.name
        }
    }

    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profile.layer.cornerRadius = profile.bounds.size.height/2
        profile.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
