//
//  PostCell.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/19/25.
//

import UIKit

// MARK: - Feed Cell (shows username and notes)
class PostCell: UITableViewCell {
    
    // UI Elements - Now created programmatically
    private let postImageView = UIImageView()
    private let levelLabel = UILabel()
    private let attemptsLabel = UILabel()
    private let usernameLabel = UILabel()
    private let notesLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let containerView = UIView()
    private let textStackView = UIStackView()
    private let headerStackView = UIStackView()
    private let metaStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupUI() {
        // Configure container
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOpacity = 0.1
        
        // Configure image view
        postImageView.layer.cornerRadius = 8
        postImageView.clipsToBounds = true
        postImageView.contentMode = .scaleAspectFill
        postImageView.backgroundColor = .systemGray6
        
        // Configure labels
        levelLabel.font = UIFont.boldSystemFont(ofSize: 18)
        levelLabel.textColor = .label
        
        attemptsLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        attemptsLabel.textColor = .systemOrange
        
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        usernameLabel.textColor = .systemBlue
        
        notesLabel.font = UIFont.systemFont(ofSize: 15)
        notesLabel.textColor = .label
        notesLabel.numberOfLines = 0
        
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = .systemGray
        
        // Configure stack views
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.distribution = .fill
        headerStackView.spacing = 8
        
        metaStackView.axis = .horizontal
        metaStackView.alignment = .center
        metaStackView.distribution = .fill
        metaStackView.spacing = 12
        
        textStackView.axis = .vertical
        textStackView.alignment = .fill
        textStackView.distribution = .fill
        textStackView.spacing = 8
        
        // Add arranged subviews
        headerStackView.addArrangedSubview(usernameLabel)
        headerStackView.addArrangedSubview(UIView()) // Spacer
        headerStackView.addArrangedSubview(dateLabel)
        
        metaStackView.addArrangedSubview(levelLabel)
        metaStackView.addArrangedSubview(attemptsLabel)
        metaStackView.addArrangedSubview(UIView()) // Spacer
        
        textStackView.addArrangedSubview(headerStackView)
        textStackView.addArrangedSubview(metaStackView)
        textStackView.addArrangedSubview(notesLabel)
        
        // Set content priorities
        usernameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        levelLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        attemptsLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Add to hierarchy
        containerView.addSubview(postImageView)
        containerView.addSubview(textStackView)
        contentView.addSubview(containerView)
        
        // Configure selection style
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        // Disable autoresizing masks
        containerView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Container constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Image constraints
            postImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            postImageView.widthAnchor.constraint(equalToConstant: 80),
            postImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Text stack constraints
            textStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            textStackView.leadingAnchor.constraint(equalTo: postImageView.trailingAnchor, constant: 12),
            textStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        levelLabel.text = nil
        attemptsLabel.text = nil
        usernameLabel.text = nil
        notesLabel.text = nil
        dateLabel.text = nil
    }
}


