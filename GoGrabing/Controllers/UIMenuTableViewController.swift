//
//  UIMenuTableViewController.swift
//  GoGrabing
//
//  Created by Darshan,Bhavik, Madan, Farshad on 2020-03-22.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

//Enum for MenuType
enum MenuType: Int {
    case HOME
    case CORE_DATA
    case CAMEA
    case MAP
}



//UIMenuTableViewController
class UIMenuTableViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Added Menu
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        //print("!!!!!!!!!!!!!!    \(menuType)")
        dismiss(animated: true){ [weak self] in
            self?.didTapMenuType?(menuType)
        }
    
    }
}
