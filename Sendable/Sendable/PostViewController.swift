//
//  PostViewController.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/18/25.
//

import UIKit
import PhotosUI

class PostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // UI Elements - Now created programmatically
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainStackView = UIStackView()
    
    private let imageContainerView = UIView()
    private let imageView = UIImageView()
    private let uploadButton = UIButton(type: .system)
    
    private let levelContainerView = UIView()
    private let levelLabel = UILabel()
    private let levelButton = UIButton(type: .system)
    
    private let attemptsContainerView = UIView()
    private let attemptsLabel = UILabel()
    private let attemptsCountLabel = UILabel()
    private let attemptsStepper = UIStepper()
    
    private let notesContainerView = UIView()
    private let notesLabel = UILabel()
    private let notesTextView = UITextView()
    
    private let buttonsContainerView = UIView()
    private let saveButton = UIButton(type: .system)
    private let postButton = UIButton(type: .system)
    
    // Properties
    private var selectedLevel = "V0"
    private var currentAttempts = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Configure navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        // Configure scroll view
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        
        // Configure content view
        contentView.backgroundColor = .systemBackground
        
        // Configure main stack view
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 24
        
        // Setup image section
        setupImageSection()
        
        // Setup level section
        setupLevelSection()
        
        // Setup attempts section
        setupAttemptsSection()
        
        // Setup notes section
        setupNotesSection()
        
        // Setup buttons section
        setupButtonsSection()
        
        // Add sections to main stack
        mainStackView.addArrangedSubview(imageContainerView)
        mainStackView.addArrangedSubview(levelContainerView)
        mainStackView.addArrangedSubview(attemptsContainerView)
        mainStackView.addArrangedSubview(notesContainerView)
        mainStackView.addArrangedSubview(buttonsContainerView)
        
        // Add to hierarchy
        contentView.addSubview(mainStackView)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
    }
    
    private func setupImageSection() {
        // Container styling
        imageContainerView.backgroundColor = .secondarySystemBackground
        imageContainerView.layer.cornerRadius = 12
        
        // Image view setup
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.backgroundColor = .systemGray6
        
        // Set placeholder image
        imageView.image = UIImage(systemName: "photo.badge.plus")
        imageView.tintColor = .systemGray3
        
        // Upload button setup
        uploadButton.setTitle("Choose Photo", for: .normal)
        uploadButton.setTitleColor(.systemBlue, for: .normal)
        uploadButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        uploadButton.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        uploadButton.layer.cornerRadius = 8
        
        imageContainerView.addSubview(imageView)
        imageContainerView.addSubview(uploadButton)
    }
    
    private func setupLevelSection() {
        levelContainerView.backgroundColor = .secondarySystemBackground
        levelContainerView.layer.cornerRadius = 12
        
        levelLabel.text = "Climbing Level"
        levelLabel.font = UIFont.boldSystemFont(ofSize: 18)
        levelLabel.textColor = .label
        
        levelButton.setTitle(selectedLevel, for: .normal)
        levelButton.setTitleColor(.white, for: .normal)
        levelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        levelButton.backgroundColor = .systemBlue
        levelButton.layer.cornerRadius = 8
        
        levelContainerView.addSubview(levelLabel)
        levelContainerView.addSubview(levelButton)
    }
    
    private func setupAttemptsSection() {
        attemptsContainerView.backgroundColor = .secondarySystemBackground
        attemptsContainerView.layer.cornerRadius = 12
        
        attemptsLabel.text = "Number of Attempts"
        attemptsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        attemptsLabel.textColor = .label
        
        attemptsCountLabel.text = "1"
        attemptsCountLabel.font = UIFont.boldSystemFont(ofSize: 24)
        attemptsCountLabel.textColor = .systemOrange
        attemptsCountLabel.textAlignment = .center
        
        attemptsStepper.minimumValue = 1
        attemptsStepper.maximumValue = 50
        attemptsStepper.value = 1
        attemptsStepper.tintColor = .systemBlue
        
        attemptsContainerView.addSubview(attemptsLabel)
        attemptsContainerView.addSubview(attemptsCountLabel)
        attemptsContainerView.addSubview(attemptsStepper)
    }
    
    private func setupNotesSection() {
        notesContainerView.backgroundColor = .secondarySystemBackground
        notesContainerView.layer.cornerRadius = 12
        
        notesLabel.text = "Notes"
        notesLabel.font = UIFont.boldSystemFont(ofSize: 18)
        notesLabel.textColor = .label
        
        notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.cornerRadius = 8
        notesTextView.font = UIFont.systemFont(ofSize: 16)
        notesTextView.backgroundColor = .systemBackground
        notesTextView.textColor = .label
        
        notesContainerView.addSubview(notesLabel)
        notesContainerView.addSubview(notesTextView)
    }
    
    private func setupButtonsSection() {
        buttonsContainerView.backgroundColor = .clear
        
        // Save button
        saveButton.setTitle("Save to Profile", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        saveButton.backgroundColor = .systemGreen
        saveButton.layer.cornerRadius = 12
        
        // Post button
        postButton.setTitle("Share to Feed", for: .normal)
        postButton.setTitleColor(.white, for: .normal)
        postButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        postButton.backgroundColor = .systemBlue
        postButton.layer.cornerRadius = 12
        
        buttonsContainerView.addSubview(saveButton)
        buttonsContainerView.addSubview(postButton)
    }
    
    private func setupConstraints() {
        // Disable autoresizing masks
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelButton.translatesAutoresizingMaskIntoConstraints = false
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsStepper.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesTextView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        postButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content view constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Main stack view constraints
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Image section constraints
            imageContainerView.heightAnchor.constraint(equalToConstant: 240),
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            
            uploadButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            uploadButton.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 16),
            uploadButton.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -16),
            uploadButton.heightAnchor.constraint(equalToConstant: 40),
            uploadButton.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -16),
            
            // Level section constraints
            levelContainerView.heightAnchor.constraint(equalToConstant: 80),
            levelLabel.topAnchor.constraint(equalTo: levelContainerView.topAnchor, constant: 16),
            levelLabel.leadingAnchor.constraint(equalTo: levelContainerView.leadingAnchor, constant: 16),
            
            levelButton.centerYAnchor.constraint(equalTo: levelContainerView.centerYAnchor),
            levelButton.trailingAnchor.constraint(equalTo: levelContainerView.trailingAnchor, constant: -16),
            levelButton.widthAnchor.constraint(equalToConstant: 80),
            levelButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Attempts section constraints
            attemptsContainerView.heightAnchor.constraint(equalToConstant: 80),
            attemptsLabel.topAnchor.constraint(equalTo: attemptsContainerView.topAnchor, constant: 16),
            attemptsLabel.leadingAnchor.constraint(equalTo: attemptsContainerView.leadingAnchor, constant: 16),
            
            attemptsCountLabel.centerYAnchor.constraint(equalTo: attemptsContainerView.centerYAnchor),
            attemptsCountLabel.trailingAnchor.constraint(equalTo: attemptsStepper.leadingAnchor, constant: -12),
            attemptsCountLabel.widthAnchor.constraint(equalToConstant: 50),
            
            attemptsStepper.centerYAnchor.constraint(equalTo: attemptsContainerView.centerYAnchor),
            attemptsStepper.trailingAnchor.constraint(equalTo: attemptsContainerView.trailingAnchor, constant: -16),
            
            // Notes section constraints
            notesContainerView.heightAnchor.constraint(equalToConstant: 160),
            notesLabel.topAnchor.constraint(equalTo: notesContainerView.topAnchor, constant: 16),
            notesLabel.leadingAnchor.constraint(equalTo: notesContainerView.leadingAnchor, constant: 16),
            
            notesTextView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 8),
            notesTextView.leadingAnchor.constraint(equalTo: notesContainerView.leadingAnchor, constant: 16),
            notesTextView.trailingAnchor.constraint(equalTo: notesContainerView.trailingAnchor, constant: -16),
            notesTextView.bottomAnchor.constraint(equalTo: notesContainerView.bottomAnchor, constant: -16),
            
            // Buttons section constraints
            buttonsContainerView.heightAnchor.constraint(equalToConstant: 60),
            saveButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor),
            saveButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            postButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor),
            postButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor),
            postButton.heightAnchor.constraint(equalToConstant: 50),
            postButton.leadingAnchor.constraint(equalTo: saveButton.trailingAnchor, constant: 12),
            postButton.widthAnchor.constraint(equalTo: saveButton.widthAnchor)
        ])
    }
    
    private func setupActions() {
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
        levelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
        attemptsStepper.addTarget(self, action: #selector(attemptsStepperChanged), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
    }
    
    @objc private func attemptsStepperChanged(_ sender: UIStepper) {
        currentAttempts = Int(sender.value)
        attemptsCountLabel.text = "\(currentAttempts)"
    }
    
    @objc private func postButtonTapped() {
        savePost(toFeed: true)
    }
    
    @objc private func saveButtonTapped() {
        savePost(toFeed: false)
    }
    
    @objc private func levelButtonTapped() {
        presentLevelPicker()
    }
    
    private func presentLevelPicker() {
        let alertController = UIAlertController(title: "Select Level", message: nil, preferredStyle: .actionSheet)
        
        for i in 0...12 {
            let level = "V\(i)"
            alertController.addAction(UIAlertAction(title: level, style: .default) { _ in
                self.selectedLevel = level
                self.levelButton.setTitle(level, for: .normal)
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alertController.popoverPresentationController {
            popover.sourceView = levelButton
            popover.sourceRect = levelButton.bounds
        }
        
        present(alertController, animated: true)
    }
    
    private func savePost(toFeed: Bool) {
        guard let image = imageView.image,
              image != UIImage(systemName: "photo.badge.plus") else {
            showAlert(message: "Please select an image")
            return
        }
        
        guard !notesTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showAlert(message: "Please add some notes")
            return
        }
        
        let post = Post(
            image: image,
            level: selectedLevel,
            notes: notesTextView.text.trimmingCharacters(in: .whitespacesAndNewlines),
            attempts: currentAttempts,
            username: "Anonymous" // You can add username input later
        )
        
        if toFeed {
            PostDataManager.shared.saveFeedPost(post)
            showAlert(message: "Post shared to feed!", title: "Success") {
                self.clearForm()
            }
        } else {
            PostDataManager.shared.saveSavedPost(post)
            showAlert(message: "Post saved to your profile!", title: "Success") {
                self.clearForm()
            }
        }
    }
    
    private func clearForm() {
        imageView.image = UIImage(systemName: "photo.badge.plus")
        imageView.tintColor = .systemGray3
        notesTextView.text = ""
        selectedLevel = "V0"
        levelButton.setTitle("V0", for: .normal)
        currentAttempts = 1
        attemptsStepper.value = 1
        attemptsCountLabel.text = "1"
    }
    
    private func showAlert(message: String, title: String = "Alert", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    @objc private func uploadButtonTapped() {
        presentImagePicker()
    }
    
    private func presentImagePicker() {
        let alertController = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
                self.openImagePicker(sourceType: .camera)
            })
        }
        
        alertController.addAction(UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.openImagePicker(sourceType: .photoLibrary)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if let popover = alertController.popoverPresentationController {
            popover.sourceView = uploadButton
            popover.sourceRect = uploadButton.bounds
        }
        
        present(alertController, animated: true)
    }
    
    private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        imageView.tintColor = .label
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
