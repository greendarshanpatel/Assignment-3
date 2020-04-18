//
//  ItemViewController.swift
//  GoGrabing
//
//  Created by Darshan,Bhavik, Madan, Farshad on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit



//ItemViewController
class ItemViewController: UIViewController {
    var itemCount : Double = 1
//    Intialize control
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemTypeLbl: UILabel!
    @IBOutlet weak var StoreNameLbl: UILabel!
    @IBOutlet weak var stepperLbl: UILabel!
    @IBAction func QuantityStepper(_ sender: UIStepper) {
        stepperLbl.text = "\(sender.value)"
        itemCount = Double(sender.value)
    }
   
    var showItem : Item!
    var userCart = Cart(cartCost: 0.0, cartItems: [])
    
    
//    Display selected items information
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(showItem.name) at \(showItem.store.storeName) "
        
        // Do any additional setup after loading the view.
        nameLbl.text = showItem.name
        if let image = UIImage(named: showItem.image){
        imageView.image = image }
        price.text = "$\(String(showItem.cost))"
        itemTypeLbl.text = showItem.itemType.itemType
        StoreNameLbl.text = showItem.store.storeName
        stepperLbl.text = "1"
        
    }
    
//  click event for Add to cart button
    @IBAction func AddToCart(_ sender: Any) {
        // if rr == true {
        userCart.cartCost += showItem.cost * itemCount
        let itemsWithQuantity = Cart.cartStuff.init(StuffItem: showItem, Stuffquantity: itemCount)
        userCart.cartItems.append(itemsWithQuantity)
         showAlert(for: "\(itemCount) \(showItem.name) added to cart")
       
    }

//    click event for view cart
    @IBAction func ViewCartPressed(_ sender: Any) {
        showAlert(for: "Cart Not Available")
    }

//    Display alert
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
