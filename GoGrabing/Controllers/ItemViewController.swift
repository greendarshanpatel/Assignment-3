//
//  ItemViewController.swift
//  GoGrabing
//
//  Created by Darshan Patel on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemTypeLbl: UILabel!
    @IBOutlet weak var StoreNameLbl: UILabel!
    
    
    
    
    var showItem : Item!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(showItem.name) at \(showItem.store.storeName) "

        // Do any additional setup after loading the view.
        nameLbl.text = showItem.name
        if let image = UIImage(named: showItem.image){
        imageView.image = image }
        price.text = String(showItem.cost)
        itemTypeLbl.text = showItem.itemType.itemType
        StoreNameLbl.text = showItem.store.storeName
        
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
