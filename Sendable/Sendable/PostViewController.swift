//
//  PostViewController.swift
//  Sendable
//
//  Created by Iker Gonzalez on 11/18/25.
//

import UIKit
import PhotosUI

class PostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //outlets
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsStepper: UIStepper!
    
    // Properties
    private var selectedLevel = "V0"
    private var currentAttempts = 1
    
    @IBAction func attemptsStepper(_ sender: UIStepper) {
        currentAttempts = Int(sender.value)
        attemptsLabel.text = "\(currentAttempts)"
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        savePost(toFeed: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        savePost(toFeed: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupUploadButton()
        setupImageView()
        setupLevelButton()
        setupStepper()
        setupTextView()
    }
    
    private func setupUploadButton() {
        uploadButton.addTarget(self, action: #selector(uploadButtonTapped), for: .touchUpInside)
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        
        // Set placeholder image
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .systemGray3
    }
    
    private func setupStepper() {
        attemptsStepper.minimumValue = 1
        attemptsStepper.maximumValue = 50
        attemptsStepper.value = 1
        attemptsLabel.text = "1"
    }
    
    private func setupTextView() {
        notesTextView.layer.borderColor = UIColor.systemGray4.cgColor
        notesTextView.layer.borderWidth = 1
        notesTextView.layer.cornerRadius = 8
        notesTextView.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func setupLevelButton() {
        levelButton.setTitle(selectedLevel, for: .normal)
        levelButton.layer.borderColor = UIColor.systemBlue.cgColor
        levelButton.layer.borderWidth = 1
        levelButton.layer.cornerRadius = 8
        levelButton.addTarget(self, action: #selector(levelButtonTapped), for: .touchUpInside)
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
              image != UIImage(systemName: "photo") else {
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
        imageView.image = UIImage(systemName: "photo")
        imageView.tintColor = .systemGray3
        notesTextView.text = ""
        selectedLevel = "V0"
        levelButton.setTitle("V0", for: .normal)
        currentAttempts = 1
        attemptsStepper.value = 1
        attemptsLabel.text = "1"
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
