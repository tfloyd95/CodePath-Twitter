//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by ARG Lab on 3/11/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var TweetView: UIView!
    @IBOutlet weak var FollowingView: UIView!
    @IBOutlet weak var FollowersView: UIView!
    
    
    
    
    var user = User.current
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.af_setImage(withURL: (user?.profileImageUrl!)!)
        // Do any additional setup after loading the view.
        tweetsLabel.text = user?.tweets.description
        followerLabel.text = user?.followers.description
        followingLabel.text = user?.following.description
        
    }

    @IBAction func viewPicker(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //tweets
            TweetView.isHidden = false
            FollowingView.isHidden = true
            FollowersView.isHidden = true
        case 1:
            //following
            TweetView.isHidden = true
            FollowingView.isHidden = false
            FollowersView.isHidden = true
        default:
            //followers
            TweetView.isHidden = true
            FollowingView.isHidden = true
            FollowersView.isHidden = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
