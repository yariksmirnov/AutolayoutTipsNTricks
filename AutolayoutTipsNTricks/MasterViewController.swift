//
//  MasterViewController.swift
//  AutolayoutTipsNTricks
//
//  Created by Yaroslav Smirnov on 30/03/16.
//  Copyright © 2016 Yaroslav Smirnov. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                               for: .any,
                                                               barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Onboarding"
        case 1:
            cell.textLabel?.text = "Sticky Image"
        case 2:
            cell.textLabel?.text = "Sticky Table View Header"
        default:
            cell.textLabel?.text = nil
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewController: UIViewController?
        switch indexPath.row {
        case 0:
            viewController = OnboardingViewController()
        case 1:
            viewController = StickyImageViewController()
        case 2:
            viewController = StickyHeaderViewController()
        default:
            return
        }
        if let vc = viewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

