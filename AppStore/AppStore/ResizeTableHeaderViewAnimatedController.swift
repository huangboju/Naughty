//
//  ResizeTableHeaderViewAnimatedController.swift
//  AppStore
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 xiAo_Ju. All rights reserved.
//

import UIKit

class ResizeTableHeaderViewAnimatedController: UITableViewController {
    
    fileprivate lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        headerView.backgroundColor = UIColor.red
        return headerView
    }()

    fileprivate var animated = true
    fileprivate var isShowing: Bool {
        return headerView.frame.height == 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showHeaderView))
    }

    @objc func showHeaderView() {
        let newHeight: CGFloat = isShowing ? 130 : 0

        if animated {
            // The UIView animation block handles the animation of our header view
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationCurve(.easeInOut)
            tableView.beginUpdates()
            // beginUpdates and endUpdates trigger the animation of our cells
        }

        headerView.frame.size.height = newHeight
        tableView.tableHeaderView = headerView

        if animated {
            tableView.endUpdates()
            UIView.commitAnimations()
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: isShowing ? .add : .trash, target: self, action: #selector(showHeaderView))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let switchView = UISwitch()
            switchView.isOn = animated
            switchView.addTarget(self, action: #selector(valueChange), for: .valueChanged)
            cell.accessoryView = switchView
        } else {
            cell.accessoryView = nil
        }
    }

    @objc func valueChange(sender: UISwitch) {
        animated = sender.isOn
    }
}
