//
//  TweetComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by ARG Lab on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}

class TweetComposeViewController: UIViewController , UITextViewDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetView: UITextView!
    @IBOutlet weak var characterCount: UIBarButtonItem!
  
    var delegate: ComposeViewControllerDelegate?

    var tweet : Tweet?
    
    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.af_setImage(withURL: (User.current?.profileImageUrl!)!)
        tweetView.delegate = self
        characterCount.title = ""
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func repostButton(_ sender: Any) {
        var parameters : [String : Any] = [:]
        if let tweet = tweet{
            parameters = ["status" : tweetView.text, "in_reply_to_status_id" : tweet.id]
        }else{
            parameters = ["status" : tweetView.text]
        }
        
        APIManager.shared.composeTweet(with: parameters){
            (tweet: Tweet?, error: Error?) in
            if let error = error{
                print(error.localizedDescription)
            }else if let tweet = tweet{
                self.delegate?.did(post: tweet)
                print("success")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        var characterCount = newText.description.count
        // TODO: Update Character Count Label
        self.characterCount.title = characterCount.description
        
        // The new text should be allowed? True/False
        return  characterCount < characterLimit
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
