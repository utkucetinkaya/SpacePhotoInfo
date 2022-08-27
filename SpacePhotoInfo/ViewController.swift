//
//  ViewController.swift
//  SpacePhotoInfo


import UIKit

class ViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet var imageView : UIImageView!
    @IBOutlet var descriptionLabel : UILabel!
    @IBOutlet var copyrightLabel : UILabel!
  
    // MARK: - Properties
    let networkController = NetworkController()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        networkController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
    }

    // MARK: - Functions
    func updateUI(with photoInfo : PhotoInfo) {
        networkController.fetchPhoto(from: photoInfo.url) { (image) in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.title = photoInfo.title
                self.descriptionLabel.text = photoInfo.description
                
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text = copyright
                    
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        }
    }
}

