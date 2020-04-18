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
    
    var DataRecived = [Item]()
    var result : ItemResponce?
    var selectedItem : Item!
    let transition = SlideInTransition()
       
       
       @available(iOS 13.0, *)
       @IBAction func didsTapMenu(_ sender: UIBarButtonItem) {
           guard let menuViewController = storyboard?.instantiateViewController(identifier: "UIMenuTableViewController") as? UIMenuTableViewController else {return}
           menuViewController.didTapMenuType = { menuType in
               self.transitionToNew(menuType)
           }
           menuViewController.modalPresentationStyle = .overCurrentContext
           menuViewController.transitioningDelegate = self
           present(menuViewController, animated: true)
           
       }
       
       
       func transitionToNew(_ menuType: MenuType)
       {
        //print("!!!!!!!!!!!!!!!!!!!")
        //print(menuType)
           if let tabBarController = self.view.window!.rootViewController as? UITabBarController {
               switch menuType {
               case .HOME:
                   tabBarController.selectedIndex = 0
                   break
                   case .CORE_DATA:
                       tabBarController.selectedIndex = 1
                   break
                   case .CAMEA:
                       tabBarController.selectedIndex = 2
                   break
                   case .MAP:
                       tabBarController.selectedIndex = 3
                   break
               default:
                   tabBarController.selectedIndex = 0
                   break
               }
               
           }
       }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        callit()
       
    }
    
    private func callit() {
        let myUrl = "https://grabapi.azurewebsites.net/item"
                guard let url = URL(string: myUrl) else { return }
                
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    //perhaps check err
                    //also perhaps check response status 200 OK
                    
                    guard let data = data else { return }
                   
                    do {
                        self.result = try JSONDecoder().decode(ItemResponce.self, from: data)
                        print(self.result?.data.count as Any)
                        self.DataRecived = self.result?.data ?? []
                         DispatchQueue.main.async {
                            self.TableView.reloadData()
                        }
                        
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                }.resume()
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataRecived.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemTableViewCell
        
        cell.customView.layer.cornerRadius = cell.customView.frame.height / 2
        if let image = UIImage(named: DataRecived[indexPath.row].image){
            cell.productImage.image = image }
      
        cell.productImage.layer.cornerRadius = cell.productImage.frame.height / 2
        cell.productName.text = DataRecived[indexPath.row].name.capitalized
        cell.productCost.text = "$\(String(DataRecived[indexPath.row].cost))"
        if let imageTwo = UIImage(named: "\(DataRecived[indexPath.row].store.storeName).png"){
        cell.StoreImage.image = imageTwo }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = DataRecived[indexPath.row]
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
        if (searchText.count != 0) {
            DataRecived = DataRecived.filter({(Item) -> Bool in
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
        DataRecived = []
       callit()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        SearchBar.setShowsCancelButton(false, animated: true)
        SearchBar.endEditing(true)
    }
}

extension ItemsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}



