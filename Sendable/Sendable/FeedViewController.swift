//
//  FeedViewController.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/18/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    // UI Elements - Now created programmatically
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    private var feedPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFeedPosts()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Configure navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Add refresh button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonTapped)
        )
        
        // Setup table view
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        
        // Add to view hierarchy
        view.addSubview(tableView)
        
        // Setup constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        // Register the cell programmatically
        tableView.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        
        // Setup pull-to-refresh
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func loadFeedPosts() {
        feedPosts = PostDataManager.shared.getFeedPosts().reversed() // Show newest first
        tableView.reloadData()
    }
    
    @objc private func refreshButtonTapped() {
        loadFeedPosts()
    }
    
    @objc private func refreshData() {
        loadFeedPosts()
        refreshControl.endRefreshing()
    }
}

// MARK: - TableView DataSource & Delegate
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = feedPosts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    // Empty state
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if feedPosts.isEmpty {
            let emptyView = createEmptyStateView(
                title: "No Posts Yet",
                message: "Posts from the community will appear here.\nCreate your first post to get started!",
                imageName: "photo.on.rectangle.angled"
            )
            return emptyView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return feedPosts.isEmpty ? 300 : 0
    }
    
    // Swipe to delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Calculate the correct index for the data manager (since we're showing reversed)
            let actualIndex = PostDataManager.shared.getFeedPosts().count - 1 - indexPath.row
            
            // Remove from data manager
            PostDataManager.shared.deleteFeedPost(at: actualIndex)
            
            // Remove from local array
            feedPosts.remove(at: indexPath.row)
            
            // Remove from table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Show empty state if needed
            if feedPosts.isEmpty {
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
    
    private func createEmptyStateView(title: String, message: String, imageName: String) -> UIView {
        let emptyView = UIView()
        let stackView = UIStackView()
        let imageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        // Configure image
        imageView.image = UIImage(systemName: imageName)
        imageView.tintColor = .systemGray3
        imageView.contentMode = .scaleAspectFit
        
        // Configure title
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .systemGray2
        titleLabel.textAlignment = .center
        
        // Configure message
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textColor = .systemGray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        // Configure stack view
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        
        emptyView.addSubview(stackView)
        
        // Setup constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            
            stackView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: emptyView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: emptyView.trailingAnchor, constant: -40)
        ])
        
        return emptyView
    }
}
