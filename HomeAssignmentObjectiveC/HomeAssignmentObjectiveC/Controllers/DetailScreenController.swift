//
//  DetailScreenController.swift
//  HomeAssignmentObjectiveC
//
//  Created by Olga Rudina on 2021-04-01.
//

import UIKit
import AVFoundation

class DetailScreenController: UIViewController {
    
    @IBOutlet weak var likeIcon: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var commentsIcon: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    @objc var post = PostModel()
    @objc var selectedPostImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = post.title;
        likeIcon.attributedText = NSMutableAttributedString (string: "\u{f004}")
        commentsIcon.attributedText  = NSMutableAttributedString (string: "\u{f086}")
        titleLabel.text = post.title
        bodyLabel.text = post.desc
        upvotesLabel.text = post.upvotes.stringValue
        commentsLabel.text = post.numComments.stringValue
        postImage.image = selectedPostImage
        
        if (selectedPostImage.size.height > 0.0) {
            postImage.isHidden = false
            imageHeight.constant = AVMakeRect(aspectRatio: selectedPostImage.size, insideRect: self.view.bounds).size.height;
            postImage.image = selectedPostImage

        } else {
            imageHeight.constant = 0.0;
            postImage.isHidden = true
        }
    }

}
