//
//  UIMenuTableViewController.swift
//  GoGrabing
//
//  Created by Farshad on 2020-04-17.
//  Copyright © 2020 GoGrabing. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case HOME
    case CORE_DATA
    case CAMEA
    case MAP
}


class UIMenuTableViewController: UITableViewController {

    var didTapMenuType: ((MenuType) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        //print("!!!!!!!!!!!!!!    \(menuType)")
        dismiss(animated: true){ [weak self] in
            self?.didTapMenuType?(menuType)
        }
    
    }
}
