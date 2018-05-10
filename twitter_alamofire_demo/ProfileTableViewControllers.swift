//
//  ProfileTableViewControllers.swift
//  twitter_alamofire_demo
//
//  Created by ARG Lab on 3/24/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class UserTweetsTableView: UIViewController,  UITableViewDataSource, UITableViewDelegate{
    
    var usertweets : [Tweet] = []
    @IBOutlet weak var tweetTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTable.dataSource = self
        tweetTable.delegate = self
        // Do any additional setup after loading the view.
        APIManager.shared.getUserTimeLine{
            (tweets : [Tweet]?, error: Error?) in
            if let tweets = tweets{
                self.usertweets = tweets
                self.tweetTable.reloadData()
            }else{
                print(error?.localizedDescription)
            }
        }
        tweetTable.rowHeight = UITableViewAutomaticDimension
        tweetTable.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usertweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTable.dequeueReusableCell(withIdentifier: "UserTweetCell") as! TweetTableViewCell
        let tweet = usertweets[indexPath.row]
        cell.tweet = tweet
        return cell
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
class FollowersTableView: UIViewController ,  UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var followersTable: UITableView!
    var followers : [User] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        followersTable.delegate = self
        followersTable.dataSource = self
        APIManager.shared.getFollowers(user: User.current!){
            (users : [User]?, error: Error?) in
            if let users = users{
                self.followers = users
                self.followersTable.reloadData()
                print(users)
            }else{
                print(error?.localizedDescription)
            }
         }
        // Do any additional setup after loading the view.
        followersTable.rowHeight = UITableViewAutomaticDimension
        followersTable.estimatedRowHeight = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followersTable.dequeueReusableCell(withIdentifier: "FollowerCell") as! FollowerCell
        let user = followers[indexPath.row]
        cell.user = user
        return cell
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
class FollowingTableView: UIViewController ,  UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var followingTable: UITableView!
    var following : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followingTable.dataSource = self
        followingTable.delegate = self
        // Do any additional setup after loading the view.
        APIManager.shared.getFollowing{
            (users: [User]?, error: Error?) in
            if let users = users{
                self.following = users
                self.followingTable.reloadData()
                print("Following")
            }else{
                print(error?.localizedDescription)
            }
        }
        followingTable.rowHeight = UITableViewAutomaticDimension
        followingTable.estimatedRowHeight = 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return following.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = followingTable.dequeueReusableCell(withIdentifier: "FollowingCell") as! FollowingCell
        let user = following[indexPath.row]
        cell.user = user
        return cell
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
