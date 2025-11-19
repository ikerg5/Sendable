//
//  FeedViewController.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/18/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var feedPosts: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFeedPosts()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    private func loadFeedPosts() {
        feedPosts = PostDataManager.shared.getFeedPosts().reversed() // Show newest first
        tableView.reloadData()
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
    
    // Optional: Add swipe to delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove from data source
            PostDataManager.shared.deleteFeedPost(at: indexPath.row)
            feedPosts.remove(at: indexPath.row)
            
            // Remove from table view
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
