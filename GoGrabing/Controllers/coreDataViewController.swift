//
//  coreDataViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit
import CoreData

class coreDataViewController: UIViewController {

    //https://www.raywenderlich.com/7569-getting-started-with-core-data-tutorial#toc-anchor-002
    // follow above steps
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var stepperValue : Double = 0.0
    @IBOutlet weak var stepperLbl: UILabel!
    @IBAction func stepper(_ sender: UIStepper) {
        stepperLbl.text = "\(sender.value)"
        stepperValue = sender.value
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
      
    }
    @IBAction func getValuePressed(_ sender: Any) {
//
        
    }
    
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
