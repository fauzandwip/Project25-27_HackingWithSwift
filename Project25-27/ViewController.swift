//
//  ViewController.swift
//  Project25-27
//
//  Created by Fauzan Dwi Prasetyo on 16/05/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var importPhotoButton: UIButton!
    @IBOutlet weak var topTextButton: UIButton!
    @IBOutlet weak var bottomTextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        importPhotoButton.layer.borderWidth = 3
        importPhotoButton.layer.borderColor = UIColor.black.cgColor
        importPhotoButton.layer.cornerRadius = 10
        
        topTextButton.layer.borderWidth = 3
        topTextButton.layer.borderColor = UIColor.black.cgColor
        topTextButton.layer.cornerRadius = 10
        
        bottomTextButton.layer.borderWidth = 3
        bottomTextButton.layer.borderColor = UIColor.black.cgColor
        bottomTextButton.layer.cornerRadius = 10
    }

    @IBAction func importPhotoTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true)
        
        imageView.image = image
    }
    
    @IBAction func topTextTapped(_ sender: Any) {
    }
    
    @IBAction func bottomTextTapped(_ sender: UIButton) {
    }
    
}

