//
//  coreDataViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class coreDataViewController: UIViewController {

    // follow above steps
    override func viewDidLoad() {
        super.viewDidLoad()
        getStored()
    }
    
    let store: ItemStore =  ItemStore()
    
    @IBAction func resignKeyBoard(_ sender: UITapGestureRecognizer) {
        txtSpngItemName.resignFirstResponder()
        txtSpngStoreName.resignFirstResponder()
    }
    
    @IBOutlet weak var txtSpngItemName: UITextField!
    @IBOutlet weak var txtSpngStoreName: UITextField!
    
    @IBOutlet weak var storedStoreName: UILabel!
    @IBOutlet weak var storedItemName: UILabel!
    @IBAction func addItem(_ sender: Any) {
        store.saveItem(itemName:txtSpngItemName.text! ,storeName: txtSpngStoreName.text!)
        showAlert(for: "\(txtSpngItemName.text ?? "Empty"),\(txtSpngStoreName.text ?? "Empty") is Saved")
//        store.saveItem(itemName:"paper" ,storeName: "Store")

    }
    
    @IBAction func viewItems(_ sender: Any) {
        getStored()
    }
    func getStored (){
        store.fetchItems{
            (result)-> Void in
            switch result {
            case let .success(items):
                for item in items {
                    self.storedItemName.text = "Saved Item \(item.name ?? "")"
                   // print("Hello, \(item.id)!  \(item.name) \n")
                    self.storedStoreName.text = "Saved Store \(item.shoppingStore!.name ?? "")"
                   // print("Hello, \(item.shoppingStore?.id)!  \(item.shoppingStore?.name) \n")
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
