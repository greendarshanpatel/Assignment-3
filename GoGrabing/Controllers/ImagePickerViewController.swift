//
//  ImagePickerViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    var popOverSubViewAdded = false
    @IBOutlet var popOverView: UIView!
    
    
    @IBAction func clearImage(_ sender: Any) {
        self.popOverView.removeFromSuperview()
        self.ImageViewOutlet.image = UIImage(named: "ImagePlaceholder")
    }
    
    @IBAction func openImageChooser(_ sender: Any) {
        self.popOverView.removeFromSuperview()
        openImageChooser()
    }
    
    var imagePicker = UIImagePickerController()
      
      override func viewDidLoad() {
          super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        self.view.addGestureRecognizer(gesture)
      }
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        if(popOverSubViewAdded)
        {
            popOverView.removeFromSuperview()
            popOverSubViewAdded = false
        }
        else{
            self.view.addSubview(popOverView)
            popOverView.center = self.view.center
            popOverSubViewAdded = true
        }
        
        
    }

      
      @IBOutlet weak var ImageViewOutlet: UIImageView!
      @IBAction func ChooseImage(_ sender: UIButton) {
        openImageChooser()
      }
    
    @IBAction func openImageChooser()
    {
        let picker = PickerController()
        picker.applyFilter = true // to apply filter after selecting the picture by default false
        picker.selectImage(self){ image in
            DispatchQueue.main.async {
                self.ImageViewOutlet.image = image
                self.ImageViewOutlet.contentMode = .scaleAspectFit
            }
        }
    }

}
