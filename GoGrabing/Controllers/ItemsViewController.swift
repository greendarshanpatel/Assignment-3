//
//  ItemsViewController.swift
//  GoGrabing
//
//  Created by Darshan Patel on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var Data = [Item]()
    var result : ItemResponce?
    var selectedItem : Item!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TableView.delegate = self
        TableView.dataSource = self
        callit()
       
    }
    
    private func callit() {
        let jsonUrlString = "https://grabapi.azurewebsites.net/item"
                guard let url = URL(string: jsonUrlString) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    //perhaps check err
                    //also perhaps check response status 200 OK
                    
                    guard let data = data else { return }
                   
                    do {
                        self.result = try JSONDecoder().decode(ItemResponce.self, from: data)
                        print(self.result?.data.count as Any)
//                        guard let _result = self.result else {return}
//                        onResult(_result)
                        self.Data = self.result?.data ?? []
                         DispatchQueue.main.async {
                            self.TableView.reloadData()
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                }.resume()
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemTableViewCell
        
        cell.customView.layer.cornerRadius = cell.customView.frame.height / 2
        if let image = UIImage(named: Data[indexPath.row].image){
            cell.productImage.image = image }
        //print(Data[indexPath.row].image)
//        var thisItemstore = Data[indexPath.row].store.storeName
//        print(thisItemstore)
        cell.productImage.layer.cornerRadius = cell.productImage.frame.height / 2
        cell.productName.text = Data[indexPath.row].name
        cell.productCost.text = String(Data[indexPath.row].cost)
        if let imageTwo = UIImage(named: "\(Data[indexPath.row].store.storeName).png"){
        cell.StoreImage.image = imageTwo }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = Data[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ItemsToItem", sender: nil)
    }
    
    //preparing to pass object when row is selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsToItem" {
            if let nextViewController = segue.destination as? ItemViewController {
                nextViewController.showItem = selectedItem //Or pass any values
            }
            
        }
    }

}

// implementing search bar and its delegate methods
extension ItemsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count != 0 {
            Data = Data.filter({ (Item) -> Bool in
                return Item.name.contains(searchText)
            })
        }
        TableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        SearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.text = ""
        SearchBar.setShowsCancelButton(false, animated: true)
        SearchBar.endEditing(true)
        callit()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.setShowsCancelButton(false, animated: true)
        SearchBar.endEditing(true)
    }
}




