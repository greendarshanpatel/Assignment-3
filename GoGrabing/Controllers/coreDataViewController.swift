//
//  coreDataViewController.swift
//  GoGrabing
//
//  Created by Darshan on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class coreDataViewController: UIViewController {

    //https://www.raywenderlich.com/7569-getting-started-with-core-data-tutorial#toc-anchor-002
    // follow above steps
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let store: ItemStore =  ItemStore()
    

    @IBOutlet weak var txtSpngItemName: UITextField!
    @IBOutlet weak var txtSpngStoreName: UITextField!
    
    @IBAction func addItem(_ sender: Any) {
        store.saveItem(itemName:txtSpngItemName.text! ,storeName: txtSpngStoreName.text!)
        
//        store.saveItem(itemName:"paper" ,storeName: "Store")

    }
    
    @IBAction func viewItems(_ sender: Any) {
        
        
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
