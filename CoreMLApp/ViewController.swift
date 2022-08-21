//
//  ViewController.swift
//  CoreMLApp
//
//  Created by Dusan Orescanin on 21/08/2022.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, PHPickerViewControllerDelegate {

    
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var imageToAnalyze: UIImageView!
    
    var picker: PHPickerViewController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker = PHPickerViewController(configuration: setupConfiguration())
        picker?.delegate = self
    }
    
    func setupConfiguration() -> PHPickerConfiguration {
        var config = PHPickerConfiguration()
        config.preferredAssetRepresentationMode = .automatic
        config.selectionLimit = 1
        config.filter = .images
        return config
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let result = results.first else { return }
        let item = result.itemProvider
        guard item.canLoadObject(ofClass: UIImage.self) else { return }
        item.loadObject(ofClass: UIImage.self) { bridgeble, error in
            if let e = error {
                print("We have an error :\(e.localizedDescription)")
            }
            if let newImage = bridgeble as? UIImage {
                DispatchQueue.main.async {
                    self.imageToAnalyze.image = newImage
                }
            }
        }
    }

    @IBAction func addPicture(_ sender: Any) {
        present(picker!, animated: true, completion: nil)
    }
    
    @IBAction func analyzePicture(_ sender: Any) {
    }
    
}

