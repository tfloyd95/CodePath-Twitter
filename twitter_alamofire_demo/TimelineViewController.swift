//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage


class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate{
    
    var tweets: [Tweet] = []
    var currentTweet : Tweet?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        tableView.refreshControl = refresh
        getTweets()
        
        
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl){
        getTweets()
        refreshControl.endRefreshing()
    }
    
    func getTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    
    func did(post: Tweet) {
        tweets.insert(post, at: 0)
        tableView.reloadData()
        print("posted tweet to timeline")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("row \(indexPath.row) selected" )
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        if let  tweet = cell.tweet{
            tweets[indexPath.row] = tweet
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if let  indexPath = tableView.indexPathForSelectedRow {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetCell
            
            
            if(segue.identifier == "detailSegue"){
                if let vc = segue.destination as? TweetDetailViewController{
                    vc.tweet = cell?.tweet
                    
                }
            }else{
                if let vc = segue.destination as? TweetComposeViewController{
                    vc.tweet = tweets[indexPath.row]
                    vc.delegate = self
                }
            }
        }
        
        
     }
    
    
}
