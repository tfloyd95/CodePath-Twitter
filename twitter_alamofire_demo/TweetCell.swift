//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit


class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetedButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var repostLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    
    
    var tweet: Tweet! {
        didSet {
            reloadData()
        }
    }
    
    func reloadData(){
        tweetTextLabel.text = tweet.text
        usernameLabel.text = "@"+tweet.user.name
        let profileUrl = tweet.user.profileImageUrl!
        profileImage.af_setImage(withURL: profileUrl)
        timeStampLabel.text = tweet.createdAtString
        repostLabel.text = tweet.retweetCount.description
        favoriteLabel.text = tweet.favoriteCount.description
        screenNameLabel.text = tweet.user.screenName
        if let retweeted = tweet.retweetStatus{
            retweetedButton.isHidden = false
            retweetedButton.titleLabel?.text = "@" + retweeted.user.name
        }
        if tweet.favorited {
            likeButton.imageView?.image = #imageLiteral(resourceName: "favor-icon-red")
        }else{
            likeButton.imageView?.image = #imageLiteral(resourceName: "favor-icon")
        }
        if tweet.retweeted {
            repostButton.imageView?.image = #imageLiteral(resourceName: "retweet-icon-green")
        }else{
            repostButton.imageView?.image = #imageLiteral(resourceName: "retweet-icon")
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 8
        profileImage.clipsToBounds = true
        
 
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func reply(_ sender: UIButton) {
        
    }
    @IBAction func like(_ sender: UIButton) {
        
        
        if tweet.favorited == true {
          sender.imageView?.image = #imageLiteral(resourceName: "favor-icon")
            APIManager.shared.unFavorite(tweet, completion: {(tweet: Tweet?, error: Error?) in
                if let tweet = tweet{
                    print("favorite count before: \(self.tweet.favoriteCount) after: \(tweet.favoriteCount)")
                    self.tweet = tweet
                    
                    
                    self.reloadData()
                    
                    
                }else{
                    print(error?.localizedDescription)
                }
            })
        }else{
           sender.imageView?.image = #imageLiteral(resourceName: "favor-icon-red")
            
            APIManager.shared.favorite(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let tweet = tweet{
                    print("favorite count before: \(self.tweet.favoriteCount) after: \(tweet.favoriteCount)")
                    self.tweet = tweet
                    
                    self.reloadData()
                }else{
                    print(error?.localizedDescription)
                }
            })
        }
    }
    @IBAction func repost(_ sender: UIButton) {
        
        if tweet.retweeted {
            sender.imageView?.image = #imageLiteral(resourceName: "retweet-icon")
            APIManager.shared.unRetweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let tweet = tweet{
                    print("repost count before: \(self.tweet.retweetCount) after: \(tweet.retweetCount)")
                    self.tweet = tweet
                    
                    //
                    self.reloadData()
                }else{
                    print(error?.localizedDescription)
                }
            })
        }else{
            sender.imageView?.image = #imageLiteral(resourceName: "retweet-icon-green")
            APIManager.shared.retweet(tweet, completion: { (tweet: Tweet?, error: Error?) in
                if let tweet = tweet{
                    print("repost count before: \(self.tweet.retweetCount) after: \(tweet.retweetCount)")
                    self.tweet = tweet
                    
                    self.reloadData()
                }else{
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
}
