//
//  ViewController.swift
//  Project25-27
//
//  Created by Fauzan Dwi Prasetyo on 16/05/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var importPhotoButton: UIButton!
    @IBOutlet weak var topTextButton: UIButton!
    @IBOutlet weak var bottomTextButton: UIButton!
    
    var image = UIImage()
    var textTop = ""
    var textBottom = ""
    
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
        self.image = image
        addText()
    }
    
    @IBAction func topTextTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Type text for the top", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let text = ac.textFields?[0].text else { return }
            self?.textTop = text
            self?.addText()
        })
        
        present(ac, animated: true)
    }
    
    @IBAction func bottomTextTapped(_ sender: UIButton) {
        let ac = UIAlertController(title: "Type text for the bottom", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] action in
            guard let text = ac.textFields?[0].text else { return }
            self?.textBottom = text
            self?.addText()
        })
        
        present(ac, animated: true)
    }
    
    func addText() {
        let imageViewWidth = imageView.frame.size.width
        let imageViewHeight = imageView.frame.size.height
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageViewWidth, height: imageViewHeight))
        
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 25, weight: .semibold),
                .foregroundColor: UIColor.red,
                .paragraphStyle: paragraphStyle,
            ]
            
            var attributedString = NSAttributedString(string: textTop, attributes: attrs)
            
            let imageFitSize = AVMakeRect(aspectRatio: self.image.size, insideRect: self.imageView.bounds)
            self.image.draw(in: imageFitSize)
            
            // position and size for text
            let strX = ((self.imageView.bounds.width - imageFitSize.width) / 2) + 10
            var strY = ((self.imageView.bounds.height - imageFitSize.height) / 2) + 10
            let strWidth = imageFitSize.width - 30
            let strHeight = imageFitSize.height - 30
            
            // for top text
            attributedString.draw(with: CGRect(x: strX, y: strY, width: strWidth, height: strHeight), options: .usesLineFragmentOrigin, context: nil)
            
            // for bottom text
            attributedString = NSAttributedString(string: textBottom, attributes: attrs)
            strY += imageFitSize.height - 50
            attributedString.draw(with: CGRect(x: strX, y: strY, width: strWidth, height: strHeight), options: .usesLineFragmentOrigin, context: nil)
        }
        
        imageView.image = image
    }
}

