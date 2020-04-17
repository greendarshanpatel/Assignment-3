//
//  coreDataViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class CoreDataDetailViewController: UIViewController {

    //https://www.raywenderlich.com/7569-getting-started-with-core-data-tutorial#toc-anchor-002
    // follow above steps
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let store: ItemStore =  ItemStore()

    var stepperValue : Double = 0.0
    @IBOutlet weak var stepperLbl: UILabel!
    @IBAction func stepper(_ sender: UIStepper) {
        stepperLbl.text = "\(sender.value)"
        stepperValue = sender.value
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {

        store.saveItem(itemName: "paper",storeName: "walmart")

      
    }
    @IBAction func getValuePressed(_ sender: Any) {

        store.fetchItems{
                    (result)-> Void in
                    switch result {
                    case let .success(items):
                        for item in items {
                            print("Hello, \(item.id)!  \(item.name) \n")
                            print("Hello, \(item.shoppingStore?.id)!  \(item.shoppingStore?.name) \n")
                        }
                    case .failure:
                        print("failed")
                    }
                }
    }
    
    
    func showAlert(for alert: String) {
        let alertController = UIAlertController(title: nil, message: alert, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }

}
