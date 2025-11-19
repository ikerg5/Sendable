//
//  PostCell.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/19/25.
//

import UIKit

// MARK: - Feed Cell (shows username and notes)
class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        postImageView.layer.cornerRadius = 8
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        
        levelLabel.font = UIFont.boldSystemFont(ofSize: 16)
        attemptsLabel.font = UIFont.systemFont(ofSize: 14)
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        usernameLabel.textColor = .systemBlue
        notesLabel.font = UIFont.systemFont(ofSize: 15)
        notesLabel.numberOfLines = 0 // Allow multiple lines for notes
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
    }
    
    func configure(with post: Post) {
        postImageView.image = post.image
        levelLabel.text = post.level
        attemptsLabel.text = "\(post.attempts) attempts"
        usernameLabel.text = post.username
        notesLabel.text = post.notes
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        dateLabel.text = formatter.string(from: post.dateCreated)
    }
}


