//
//  UIViewController.swift
//  AutolayoutTipsNTricks
//
//  Created by Yaroslav Smirnov on 07/04/16.
//  Copyright © 2016 Yaroslav Smirnov. All rights reserved.
//

import UIKit
import LoremIpsum
import SDWebImage

class TableHeaderView: UIView {
    @IBOutlet var imageView: UIImageView!
}

class StickyHeaderViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var headerView: TableHeaderView!
    let tableView = UITableView()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.autoPinEdgesToSuperviewEdges()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        Bundle.main.loadNibNamed("TableHeaderView", owner: self, options: nil)
        
        let headerViewContainer = UIView()
        headerViewContainer.addSubview(headerView)
        tableView.tableHeaderView = headerViewContainer
        
        NSLayoutConstraint.autoSetIdentifier("Table Header View Constraints") {
            self.headerView.autoPinEdge(toSuperviewEdge: .top)
            self.headerView.autoPinEdge(toSuperviewEdge: .bottom)
            self.headerView.autoCenterInSuperview()
            self.headerView.autoSetDimension(.width, toSize: self.view.bounds.size.width)
        }
        
        updateTableHeaderSize()
        
        let nib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    func updateTableHeaderSize() {
        headerView.layoutIfNeeded()
        let headerSize = headerView.systemLayoutSizeFitting(self.view.bounds.size)
        let headerContainer = tableView.tableHeaderView
        tableView.tableHeaderView = nil
        guard var headerBounds = headerContainer?.bounds else { return }
        headerBounds.size = CGSize(width: view.bounds.width, height: headerSize.height)
        headerContainer?.bounds = headerBounds
        tableView.tableHeaderView = headerContainer
        headerView.imageView.autoPinEdge(
            .top,
            to: .top,
            of: view,
            withOffset: 0,
            relation: .lessThanOrEqual
        )
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell",
            for: indexPath) as! UserCell
        let imageSize = CGFloat(120 + indexPath.row)
        let imageUrl = LoremIpsum.urlForPlaceholderImage(with: CGSize(width: imageSize, height: imageSize))
        cell.nameLabel.text = LoremIpsum.name()
        cell.userImageView.sd_setImage(with: imageUrl ?? nil)
        if indexPath.row % 4 > 0 {
            cell.detailsLabel.text = LoremIpsum.words(withNumber: indexPath.row % 4)
        } else {
            cell.detailsLabel.text = nil
        }
        return cell
    }
    
}

class UserCell: UITableViewCell {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
}
