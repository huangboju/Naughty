//
//  ResizeTableHeaderViewAnimatedController.swift
//  AppStore
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class AutoResizingHeaderController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate lazy var headerView: HeaderView = {
        let headerView = HeaderView(frame: .zero, target: self, action: #selector(addMoreText), secondAction: #selector(makeThisTaller))
        headerView.backgroundColor = UIColor.cyan
        return headerView
    }()

    override func viewDidLayoutSubviews() {
        // viewDidLayoutSubviews is called when labels change.
        super.viewDidLayoutSubviews()
        sizeHeaderToFit(tableView)
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)

        tableView.tableHeaderView = headerView

        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let leading = NSLayoutConstraint(item: headerView.titleLabel, attribute: .leading, relatedBy: .equal, toItem: headerView.superview!, attribute: .leading, multiplier: 1.0, constant: 30)

        let top = NSLayoutConstraint(item: headerView.titleLabel, attribute: .top, relatedBy: .equal, toItem: headerView.superview!, attribute: .top, multiplier: 1.0, constant: 30)

        let bottom = NSLayoutConstraint(item: headerView.superview!, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: headerView.secondButton, attribute: .bottom, multiplier: 1.0, constant: 30)
        headerView.superview?.addConstraints([leading, top, bottom])

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

    @objc func addMoreText() {
        headerView.textLabel.text! += "\nThis header can dynamically resize according to its contents."
    }

    @objc func makeThisTaller() {
        UIView.animate(withDuration: 0.3, animations: {
            self.tableView.beginUpdates()
            self.headerView.makeThisTallerHeight.constant += 20
            self.sizeHeaderToFit(self.tableView)
            self.tableView.endUpdates()
        })
    }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension UIViewController {
    
    /** Resize a tableView header to according to the auto layout of its contents.
     - This method can resize a headerView according to changes in a dynamically set text label. Simply place this method inside viewDidLayoutSubviews.
     - To animate constrainsts, wrap a tableview.beginUpdates and .endUpdates, followed by a UIView.animateWithDuration block around constraint changes.
     */
    func sizeHeaderToFit(_ tableView: UITableView) {
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            headerView.frame.size.height = height
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
        }
    }
    
}
