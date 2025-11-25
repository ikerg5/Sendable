//
//  ProfileViewController.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/18/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // UI Elements - Now created programmatically
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    
    private var savedPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedPosts()
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
        tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        
        // Setup pull-to-refresh
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func loadSavedPosts() {
        // Safely get posts with error handling
        do {
            let posts = PostDataManager.shared.getSavedPosts()
            savedPosts = Array(posts.reversed()) // Show newest first
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error loading saved posts: \(error)")
            savedPosts = []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // Helper method to get the correct index in the original (non-reversed) array
    private func getOriginalIndex(for reversedIndex: Int) -> Int {
        let totalCount = PostDataManager.shared.getSavedPosts().count
        return totalCount - 1 - reversedIndex
    }
    
    @objc private func refreshButtonTapped() {
        loadSavedPosts()
    }
    
    @objc private func refreshData() {
        loadSavedPosts()
        refreshControl.endRefreshing()
    }
}

// MARK: - TableView DataSource & Delegate
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        let post = savedPosts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
    
    // MARK: - Empty State
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if savedPosts.isEmpty {
            let emptyView = createEmptyStateView(
                title: "No Saved Posts",
                message: "Your saved posts will appear here.\nCreate posts and save them to your profile!",
                imageName: "person.crop.circle.badge.plus"
            )
            return emptyView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return savedPosts.isEmpty ? 300 : 0
    }
    
    // MARK: - Delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Safety check
            guard indexPath.row < savedPosts.count else {
                print("Error: Index out of bounds")
                return
            }
            
            // Calculate the correct index in the original (non-reversed) array
            let originalIndex = getOriginalIndex(for: indexPath.row)
            
            // Remove from data manager first
            PostDataManager.shared.deleteSavedPost(at: originalIndex)
            
            // Remove from local array
            savedPosts.remove(at: indexPath.row)
            
            // Remove from table view with animation
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Show empty state if needed
            if savedPosts.isEmpty {
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
