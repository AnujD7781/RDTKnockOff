//
//  RDTListingDetailVC.swift
//  ReddItKnockOff
//
//  Created by Anuj Deshmukh on 11/21/17.
//  Copyright © 2017 Anuj Deshmukh. All rights reserved.
//

import UIKit

class RDTListingDetailVC: UIViewController {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    weak var listingData : RDTListingData?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    final private func commonInit() {
        restorationIdentifier = String(describing: type(of: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension RDTListingDetailVC {
    // MARK: - UpdateView
    func updateView() {
        thumbnailImageView.imageFromServerURL(urlString: listingData?.thumbnailUrl)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
    }
    
    // MARK: - Save image
    @objc func saveTapped() {
        guard let image = thumbnailImageView.image else {
            print("Can not save")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    // MARK: - State Restoring
    override func encodeRestorableState(with coder: NSCoder) {
        guard isViewLoaded else {
            return
        }
        if let image = thumbnailImageView.image {
            coder.encode(image, forKey: "thumbnailImage")
            
        }
        super.encodeRestorableState(with: coder)
        
    }
    
    override func decodeRestorableState(with coder: NSCoder)  {
        assert(isViewLoaded, "We assume the controller is never restored without loading its view first.")
        if let image = coder.decodeObject(forKey: "thumbnailImage") {
            thumbnailImageView.image = image as? UIImage
        }
        super.decodeRestorableState(with: coder)
        
    }
}

