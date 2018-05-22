//
//  ViewController.swift
//  HPImageClassifier
//
//  Created by Hiren Patel on 22/5/18.
//  Copyright © 2018 com.hiren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    #if targetEnvironment(simulator)
    var DEVICE_IS_SIMULATOR = true
    #else
    var DEVICE_IS_SIMULATOR = false
    #endif
    
    @IBOutlet weak var checkFruitButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var classificationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func selectImageSource(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let imageSourceActions = UIAlertController(title: "Image Source", message: "Choose an image source to continue.", preferredStyle: .actionSheet)
        
        if DEVICE_IS_SIMULATOR{
            imageSourceActions.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }))
        }
        else{
            imageSourceActions.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }))
            
            imageSourceActions.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }))
        }
        
        imageSourceActions.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(imageSourceActions, animated: true)
        
    }
    
    
   @IBAction func checkFruit (_ sender:Any){
        FruitDetector.startFruitDetection(imageView){
            (results) in
            guard let fruit = results.first else {self.classificationLabel.text = "Neither an Apple nor an Orange!!!"; return}
            
            DispatchQueue.main.async {
                self.classificationLabel.text = "It's an \(fruit)"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {picker.dismiss(animated: true); print("Could not select image!"); return}
        
        imageView.image = selectedImage
        //imageView.contentMode = .scaleAspectFill
        checkFruitButton.isEnabled = true
        picker.dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
}

