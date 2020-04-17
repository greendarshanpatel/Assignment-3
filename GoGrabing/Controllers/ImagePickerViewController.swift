//
//  ImagePickerViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class ImagePickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

     var imagePicker = UIImagePickerController()
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
          
          // Do any additional setup after loading the view.
      }
      
      @IBOutlet weak var ImageViewOutlet: UIImageView!
      @IBAction func ChooseImage(_ sender: UIButton) {
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
